// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:get/get.dart';

import 'imports.dart';
import 'screens/controllers/login_controller.dart';
import 'screens/controllers/splash_controller.dart';
import 'services/auth_service.dart';
import 'util.dart';

class BaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(AuthService());
    Get.put(Util());
    Get.put(LoginController());
  }
}
