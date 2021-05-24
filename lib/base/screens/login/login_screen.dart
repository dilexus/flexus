// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:loading_overlay/loading_overlay.dart';

import '../../../base/controllers/login_controller.dart';
import '../../../base/imports.dart';
import 'widgets/login_carousel.dart';

class LoginScreen extends GetView<LoginController> {
  final int initialPage;

  LoginScreen(this.initialPage);

  @override
  Widget build(BuildContext context) {
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
