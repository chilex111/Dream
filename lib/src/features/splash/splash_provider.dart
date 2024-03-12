
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/device_info.dart';
import '../../constants/string_constants.dart';
import '../../network/api_constants.dart';
part 'splash_provider.g.dart';

late AppConfigData appConfigData;

@Riverpod(keepAlive: true)
class Splash extends _$Splash{
  @override
  Future<void> build() async {
    return _initializeData();
  }
  late PackageInfo packageInfo;

  Future<void> _initializeData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _runSetUp();
    });
  }
  Future<void> _runSetUp() async {
    packageInfo = await PackageInfo.fromPlatform();
    StringConstants.appVersion = packageInfo.version;
    StringConstants.appId = packageInfo.packageName;
    await _init();
    await _getInitialData();
    await _setupPushNotifications();
    _navigate();
  }

  Future<void> _init() async {
    appConfigData = await _getAppConfig();
  }
  ///Todo: set up client
  Future<AppConfigData> _getAppConfig() async {
    var deviceUUID = await DeviceInformation.getDeviceId();
    var deviceVersion = await DeviceInformation.getDeviceVersion();
    var deviceModel = await DeviceInformation.getDeviceModel();
    var deviceManufacturer = await DeviceInformation.getDeviceManufacturer();
    var appConfigData = AppConfigData(
      baseUrl: ApiConstants.baseUrl,
      deviceUUId: deviceUUID??"",
      deviceModel: deviceModel??"",
      deviceManufacturer: deviceManufacturer??"",
      deviceVersion: deviceVersion??"",
      devicePlatform: DeviceInformation.getPlatform(),
    );
    return appConfigData;
  }

  Future<void> _getInitialData() async {
    //var userData = CacheData.getUserData(pref: ref.read(sharedPreferencesProvider));
    await Future.wait([
     /* GeneralRepository().getCompanyTypes().then((value) => kCompanyTypes = value),
      GeneralRepository().getCountries().then((value) => kCountries = value),
      GeneralRepository().getStates().then((value) => kStates = value),
      GeneralRepository().getAllLgas().then((value) => kLgas = value),
      MarketRepository().getAmenities().then((value) => kAmenities = value),
      MarketRepository().getAssetTypes().then((value) => kAssetTypes = value),
      ProfileRepository().fetchUserDetail(userId: userData?.id.toString()??'').then((response) {
        if (response is NetworkSuccess) {
          final userData = LoginResponse.fromJson(response.data).data;
          CacheData.cacheUserData(data: userData, pref: ref.read(sharedPreferencesProvider));
        }
      })
    */]);
  }

  Future<void> _setupPushNotifications() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel( OSLogLevel.none);
    OneSignal.initialize(StringConstants.oneSignalAppId);
    StringConstants.oneSignalExternalId = appConfigData.deviceUUId;
    OneSignal.Notifications.clearAll();

    OneSignal.User.pushSubscription.addObserver((state) {
      if (kDebugMode) {
        print(OneSignal.User.pushSubscription.optedIn);
        print(OneSignal.User.pushSubscription.id);
        print(OneSignal.User.pushSubscription.token);
        print(state.current.jsonRepresentation());
      }
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      if (kDebugMode) {
        print("Has permission $state");
      }
    });

    OneSignal.Notifications.addClickListener((event) {
      if (kDebugMode) {
        print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
      }
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      if (kDebugMode) {
        print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');
      }

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();
     // this.setState(() {
        //_debugLabelString =
        "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
   // });
  }

  void _navigate(){

  }
}
class AppConfigData{
  String baseUrl;
  String devicePlatform;
  String deviceUUId;
  String deviceModel;
  String deviceManufacturer;
  String deviceVersion;
  String? deepLink;

  AppConfigData({
    this.baseUrl = "",
    this.devicePlatform = "",
    this.deviceUUId = "",
    this.deviceModel = "",
    this.deviceManufacturer = "",
    this.deviceVersion = "",
    this.deepLink,
  });
}