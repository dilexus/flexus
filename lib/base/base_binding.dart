import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/splash_controller.dart';
import 'imports.dart';
import 'util.dart';

class BaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(AuthController());
    Get.put(Util());
    Get.put(LoginController());
  }
}
