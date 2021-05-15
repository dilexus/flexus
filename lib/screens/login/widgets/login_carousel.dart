import 'package:carousel_slider/carousel_slider.dart';

import '../../../base/controllers/login_controller.dart';
import '../../../base/imports.dart';
import '../../login/sliders/forgot_password_slider.dart';
import '../../login/sliders/login_slider.dart';
import '../../login/sliders/registration_slider.dart';
import '../../login/sliders/verify_email_slider.dart';

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
