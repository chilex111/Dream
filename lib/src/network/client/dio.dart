import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/string_constants.dart';
import '../../features/splash/splash_provider.dart';
import '../../storage/shared_preferences.dart';
import '../interceptors/logging_interceptor.dart';
import '../network_response.dart';
import 'package:cookie_jar/cookie_jar.dart';

final Map<String, String> header = {
  "Content-Type": "application/json",
  'Accept': 'application/json',
};

enum RequestType {
  get, post, put, patch, delete, download
}

class Api {
  final dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: appConfigData.baseUrl,
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ));

    var cookieJar = CookieJar();

    dio.interceptors.addAll([
      LoggingInterceptor(),
      CookieManager(cookieJar),
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final pref = await SharedPreferences.getInstance();
          String? token = CacheData.getToken(pref: pref);
          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          /*if (error.response?.statusCode == 401) {
            final options = error.response!.requestOptions;
            final newAccessToken = await _refreshAccessToken();
            options.headers['Authorization'] = 'Bearer $newAccessToken';
            final originResult = await dio.fetch(options..path);
            if (originResult.statusCode != null && originResult.statusCode! ~/ 100 == 2) {
              return handler.resolve(originResult);
            }
            return handler.reject(DioError(requestOptions: options));
          }*/
          return handler.next(error);
        }
      ),
    ]);
    return dio;
  }

/*  static Future<String> _refreshAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    final tokenDio = Dio();
    tokenDio.options.baseUrl = ApiConstants.baseUrl;
    final refreshToken = CacheData.getRefreshToken(pref: pref);
    final response = await tokenDio.post(ApiConstants.refresh, data: {'refresh': refreshToken},);
    final newAccessToken = response.data['access'];
    await CacheData.cacheToken(token: newAccessToken, pref: pref);
    return newAccessToken;
  }*/

  Future<NetworkResponse> apiCall({
    required RequestType requestType,
    required String url,
    dynamic savePath,
    Map<String, dynamic>? queryParameters,
    Object? body,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    Response? result;
    try {
      switch (requestType) {
        case RequestType.get: {
          result = await dio.get(
            url,
            queryParameters: queryParameters,
            options: options??Options(headers: header),
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
          );
          break;
        }
        case RequestType.post: {
          result = await dio.post(
            url,
            data: body,
            options: options??Options(headers: header),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
          );
          break;
        }
        case RequestType.delete: {
          result = await dio.delete(
            url,
            queryParameters: queryParameters,
            data: body,
            options: options??Options(headers: header),
            cancelToken: cancelToken,
          );
          break;
        }
        case RequestType.put:
          result = await dio.put(
            url,
            queryParameters: queryParameters,
            data: body,
            options: options??Options(headers: header),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
          );
          break;
        case RequestType.patch:
          result = await dio.patch(
            url,
            queryParameters: queryParameters,
            data: body,
            options: options??Options(headers: header),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
          );
          break;
        case RequestType.download:
          result = await dio.download(
            url,
            savePath,
            queryParameters: queryParameters,
            data: body,
            options: options??Options(headers: header),
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
          );
          break;
      }
      return NetworkSuccess(result.data);
    } on DioException catch (error) {
      String? description = error.response?.data['description'];
      var message = "";
      var messageList = error.response?.data['message'];
      if (messageList != null) {
        if(messageList is List){
          message = messageList.join(" , ");
        } else {
          message = messageList.toString();
        }
      }  else {
        message = error.response?.data.toString()??StringConstants.genericErrorMessage;
      }
      return NetworkError(description??message);
    } catch (error) {
      return NetworkError(error.toString());
    }
  }
}