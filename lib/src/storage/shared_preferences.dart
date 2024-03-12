import 'dart:convert';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/string_constants.dart';

class CacheData {

  static Future<void> cacheToken({required String token, required SharedPreferences pref}) async {
    await pref.setString(StringConstants.tokenKey, token);
  }

  static Future<void> cacheRefreshToken({required String token, required SharedPreferences pref}) async {
    await pref.setString(StringConstants.refreshTokenKey, token);
  }

  static String? getToken({required SharedPreferences pref}) {
    String? token = pref.getString(StringConstants.tokenKey);
    return token;
  }

  static String? getRefreshToken({required SharedPreferences pref}) {
    String? token = pref.getString(StringConstants.refreshTokenKey);
    return token;
  }

/*  static Future<void> cacheUserData({required UserData data, required SharedPreferences pref}) async {
    await pref.setString(StringConstants.userDataKey, jsonEncode(data.toJson()));
  }

  static UserData? getUserData({required SharedPreferences pref}) {
    String? data = pref.getString(StringConstants.userDataKey);
    if (data != null)  {
      return  UserData.fromJson(jsonDecode(data));
    }
    return null;
  }*/

  static Future<void> cacheOnBoardingStatus({required bool status, required SharedPreferences pref}) async {
    await pref.setBool(StringConstants.onBoardingStatus, status);
  }

  static bool? getOnBoardingStatus({required SharedPreferences pref}) {
    return pref.getBool(StringConstants.onBoardingStatus);
  }

  static Future<void> cacheRememberMe({required RememberMe data, required SharedPreferences pref}) async {
    await pref.setString(StringConstants.rememberMe, jsonEncode(data.toJson()));
  }

  static RememberMe getRememberMe({required SharedPreferences pref}) {
    String? data = pref.getString(StringConstants.rememberMe);
    if (data != null)  {
      return  RememberMe.fromJson(jsonDecode(data));
    }
    return RememberMe(remember: false, date: DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> clearData() async {
    final pref = await SharedPreferences.getInstance();
    pref.getKeys().forEach((e) {
      if (e != StringConstants.onBoardingStatus) {
        pref.remove(e);
      }
    });
  }

}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class RememberMe {
  bool remember;
  int date;

  RememberMe({
    required this.remember,
    required this.date,
  });

  factory RememberMe.fromJson(Map<String, dynamic> json) => RememberMe(
    remember: json["remember"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "remember": remember,
    "date": date,
  };
}