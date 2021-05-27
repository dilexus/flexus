// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';

import 'imports.dart';
import 'models/auth_user.dart';

class Util extends GetxController {
  static Util get to => Get.find();

  var _logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: false,
  ));

  Logger logger() {
    return _logger;
  }

  getConfig(String configName) {
    return FlavorConfig.instance.variables[configName];
  }

  Widget getHomeScreen() {
    return Util.to.getConfig("home_screen");
  }

  setAuthUserDetails(AuthUser authUser, User user) {
    authUser.uuid = user.uid;
    authUser.name = user.displayName;
    authUser.email = user.email;
    authUser.profilePicture = user.photoURL;
    authUser.isEmailVerified = user.emailVerified;
    switch (user.providerData[0].providerId) {
      case 'facebook.com':
        authUser.authType = AuthType.facebook;
        break;
      case 'google.com':
        authUser.authType = AuthType.google;
        break;
      case 'apple.com':
        authUser.authType = AuthType.apple;
        break;
      default:
        authUser.authType = AuthType.email;
    }
  }

  String getInitials({String string, int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    for (var i = 0; i < (limitTo ?? split.length); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }

  Widget getCircularAvatar(String profilePicture, String name, BuildContext context) {
    if (profilePicture != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(profilePicture),
        radius: 50,
        backgroundColor: Colors.white,
      );
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: Text(
          Util.to.getInitials(string: name, limitTo: 2),
          style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor),
        ),
      );
    }
  }

  void showErrorSnackBar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
  }

  Map<String, Map<String, String>> getTranslations(
      Map<String, Map<String, String>> map1, Map<String, Map<String, String>> map2) {
    map1.forEach((c, o) => map1[c].forEach((k, v) => map2[c]?.putIfAbsent(k, () => v)));
    return map2;
  }
}
