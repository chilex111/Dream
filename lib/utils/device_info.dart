import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInformation {
  DeviceInformation._();

  static Future<String?> getDeviceId() async {
    String? deviceId;
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id; // unique ID on Android
    }
    return deviceId;
  }

  static String getPlatform() {
    String platform = "";
    if (Platform.isIOS) { // import 'dart:io'
      platform = "IOS";
    } else if(Platform.isAndroid) {
      platform = "Android";
    }
    return platform;
  }

  static Future<String?> getDeviceModel() async {
    String? deviceModel;
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceModel = iosDeviceInfo.model; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceModel = androidDeviceInfo.model; // unique ID on Android
    }
    return deviceModel;
  }

  static Future<String?> getDeviceManufacturer() async {
    String? deviceManufacturer;
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceManufacturer = iosDeviceInfo.systemName; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceManufacturer = androidDeviceInfo.manufacturer; // unique ID on Android
    }
    return deviceManufacturer;
  }

  static Future<String?> getDeviceVersion() async {
    String? deviceVersion;
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceVersion = iosDeviceInfo.systemVersion; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceVersion = androidDeviceInfo.version.baseOS; // unique ID on Android
    }
    return deviceVersion;
  }

}