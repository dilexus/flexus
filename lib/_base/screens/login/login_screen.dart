// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:loading_overlay/loading_overlay.dart';

import '../../../_base/imports.dart';
import 'login_controller.dart';
import 'widgets/login_carousel.dart';

class LoginScreen extends ScreenMaster<LoginController> {
  final int initialPage;

  LoginScreen(this.initialPage);

  @override
  Widget create() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                        child: Image.asset(
                      "assets/logos/logo_1024.png",
                      width: 100,
                    )),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    child: Obx(() => LoadingOverlay(
                        isLoading: controller.isLoading.value,
                        opacity: 0,
                        child: LoginCarousel(initialPage: initialPage))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class LoginSliders {
  static const login = 0;
  static const registration = 1;
  static const verify_email = 2;
  static const forgot_password = 3;
}
