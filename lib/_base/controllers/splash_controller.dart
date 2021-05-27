// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../_base/controllers/login_controller.dart';
import '../../_base/screens/login/login_screen.dart';
import '../../_base/screens/login/widgets/login_slider_master.dart';
import '../imports.dart';
import 'auth_controller.dart';

class SplashController extends GetxController {
  _startTimer() {
    new Future.delayed(Duration(seconds: Util.to.getConfig("splash_timer_seconds")), () async {
      FirebaseAuth?.instance?.currentUser?.reload();
      var user = FirebaseAuth?.instance?.currentUser;
      if (user != null) {
        Util.to.setAuthUserDetails(AuthController.to.authUser.value, user);
        if (user.emailVerified) {
          LoginController.to.afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
          Util.to.logger().i("User found, going to home screen");
          Util.to.logger().d(user);
        } else {
          await user.sendEmailVerification();
          Get.off(() => LoginScreen(LoginSliders.verify_email));
          Util.to.logger().i("User found, email is not verified");
          Util.to.logger().d(user);
        }
      } else {
        Get.off(() => LoginScreen(LoginSliders.login));
        Util.to.logger().i("User not found, going to login screen");
      }
    });
  }

  navigateOff() {
    Get.off(() => LoginScreen(LoginSliders.login));
  }

  init() {
    Firebase.initializeApp();
    Util.to.logger().i("Splash Screen Loaded.");
    _startTimer();
  }
}
