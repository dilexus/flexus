// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:carousel_slider/carousel_slider.dart';

import '../../../../_base/controllers/login_controller.dart';
import '../../../../_base/imports.dart';
import '../sliders/forgot_password_slider.dart';
import '../sliders/login_slider.dart';
import '../sliders/registration_slider.dart';
import '../sliders/verify_email_slider.dart';

class LoginCarousel extends StatelessWidget {
  final int initialPage;
  const LoginCarousel({Key key, this.initialPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: LoginController.to.sliderController,
      options: CarouselOptions(
          height: Get.height,
          viewportFraction: 1,
          initialPage: initialPage,
          scrollPhysics: NeverScrollableScrollPhysics()),
      items: [LoginSlider(), RegistrationSlider(), VerifyEmailSlider(), ForgotPasswordSlider()],
    );
  }
}
