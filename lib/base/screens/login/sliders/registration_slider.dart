import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../base/controllers/login_controller.dart';
import '../../../../base/imports.dart';
import '../../../../base/widgets/text_input.dart';
import '../widgets/login_slider_master.dart';

class RegistrationSlider extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return LoginSliderMaster(
        title: Trns.sign_up.tr,
        onBackPressed: () {
          LoginController.to.sliderController.jumpToPage(LoginSliders.login);
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
              TextInput(
                  name: 'name',
                  label: Trns.name.tr,
                  icon: Icons.person_outline,
                  obscureText: false,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.maxLength(context, 50),
                  ])),
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
              TextInput(
                  name: 'password',
                  label: Trns.password.tr,
                  icon: Icons.vpn_key,
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.maxLength(context, 50),
                    FormBuilderValidators.minLength(context, 8),
                  ])),
              TextInput(
                  name: 'confirm_password',
                  label: Trns.confirm_password.tr,
                  icon: Icons.vpn_key,
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.maxLength(context, 50),
                    FormBuilderValidators.minLength(context, 8),
                    (val) {
                      if (_formKey.currentState.fields['password']?.value != val) {
                        return Trns.warning_passwords_not_matching.tr;
                      }
                      return null;
                    }
                  ])),
              SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: Get.width, height: 48),
                child: ElevatedButton(
                  child: Text(Trns.sign_up.tr),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      var name = _formKey.currentState.fields['name']?.value;
                      var email = _formKey.currentState.fields['email']?.value;
                      var password = _formKey.currentState.fields['password']?.value;
                      LoginController.to.signUpWithEmailAndPassword(email, password, name);
                    } else {
                      Util.to.logger().e("Validation Failed");
                    }
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Trns.already_have_an_account.tr),
                  InkWell(
                      child: Text(
                        Trns.sign_in.tr,
                        style: TextStyle(
                            color: Util.to.getConfig("primary_color"), fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        LoginController.to.sliderController.jumpToPage(LoginSliders.login);
                      }),
                ],
              ),
            ]),
          ),
        ));
  }
}
