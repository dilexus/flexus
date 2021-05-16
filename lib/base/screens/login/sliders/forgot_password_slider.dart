import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../base/controllers/login_controller.dart';
import '../../../../base/imports.dart';
import '../../../../base/widgets/text_input.dart';
import '../widgets/login_slider_master.dart';

class ForgotPasswordSlider extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return LoginSliderMaster(
      title: Tr.reset_password.tr,
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
                label: Tr.email.tr,
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
                child: Text(Tr.reset.tr),
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
