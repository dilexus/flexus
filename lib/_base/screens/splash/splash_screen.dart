// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../../../_base/controllers/splash_controller.dart';
import '../../../_base/imports.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/logos/logo_1024.png",
            width: 200,
          ),
        ),
      ),
    );
  }
}
