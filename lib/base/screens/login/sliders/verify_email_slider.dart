import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../base/controllers/auth_controller.dart';
import '../../../../base/controllers/login_controller.dart';
import '../../../../base/imports.dart';
import '../../home/home_screen.dart';
import '../widgets/login_slider_master.dart';

class VerifyEmailSlider extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    _callTimer();
    return Obx(
      () => LoginSliderMaster(
        title: Tr.verify_email.tr,
        onBackPressed: AuthController.to.isEmailVerified.value
            ? null
            : () {
                LoginController.to.sliderController.animateToPage(LoginSliders.login);
              },
        child: Theme(
          data: new ThemeData(
            primaryColor: Util.to.getConfig("primary_color"),
            accentColor: Util.to.getConfig("accent_color"),
            hintColor: Util.to.getConfig("primary_color"),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Util.to.getConfig("primary_color"),
              ),
            ),
          ),
          child: FormBuilder(
            key: _formKey,
            child: Column(children: [
              AuthController.to.isEmailVerified.value
                  ? Text(Tr.email_after_verified.tr, textAlign: TextAlign.center)
                  : Text(Tr.email_is_being_verified.tr, textAlign: TextAlign.center),
              SizedBox(height: 32),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: Get.width, height: 48),
                child: ElevatedButton(
                  child: Text(Tr.next.tr),
                  onPressed: AuthController.to.isEmailVerified.value
                      ? () {
                          AuthController.to.authUser.value.isEmailVerified = true;
                          LoginController.to
                              .afterLogin()
                              .then((value) => Get.off(() => HomeScreen()));
                        }
                      : null,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _callTimer() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      FirebaseAuth?.instance?.currentUser?.reload();
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.emailVerified) {
          AuthController.to.authUser.value.isEmailVerified = true;
          AuthController.to.isEmailVerified.value = true;
          timer.cancel();
        }
      }
    });
  }
}
