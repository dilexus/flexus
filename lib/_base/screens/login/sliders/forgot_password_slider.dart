// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../_base/controllers/login_controller.dart';
import '../../../../_base/imports.dart';
import '../../../../_base/widgets/text_input.dart';
import '../widgets/login_slider_master.dart';

class ForgotPasswordSlider extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return LoginSliderMaster(
      title: Trns.reset_password.tr,
      onBackPressed: () {
        LoginController.to.sliderController.jumpToPage(LoginSliders.login);
      },
      child: Theme(
        data: new ThemeData(
          primaryColor: Util.to.getConfig("primary_color"),
          accentColor: Util.to.getConfig("accent_color"),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Util.to.getConfig("primary_color"),
            ),
          ),
        ),
        child: FormBuilder(
          key: _formKey,
          child: Column(children: [
            TextInput(
                name: 'email',
                label: Trns.email.tr,
                icon: Icons.email_outlined,
                obscureText: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                  FormBuilderValidators.maxLength(context, 50),
                ])),
            SizedBox(height: 32),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: Get.width, height: 48),
              child: ElevatedButton(
                child: Text(Trns.reset.tr),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var email = _formKey.currentState.fields['email']?.value;
                    LoginController.to.resetPassword(email);
                  } else {
                    Util.to.logger().e("Validation Failed");
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
