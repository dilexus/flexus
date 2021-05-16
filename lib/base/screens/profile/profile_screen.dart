import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../base/controllers/auth_controller.dart';
import '../../../base/controllers/profile_controller.dart';
import '../../../base/imports.dart';
import '../../../base/models/auth_user.dart';
import '../../../base/widgets/form_field_separator.dart';
import '../../../base/widgets/text_datetime_picker.dart';
import '../../../base/widgets/text_dropdown.dart';
import '../../../base/widgets/text_input.dart';

class ProfileScreen extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Tr.profile.tr)),
      body: Obx(
        () => LoadingOverlay(
          isLoading: profileController.isLoading.value,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
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
                    SizedBox(height: 8),
                    Util.to.getCircularAvatar(AuthController.to?.authUser?.value?.profilePicture,
                        AuthController.to.authUser?.value?.name, context),
                    SizedBox(height: 8),
                    Text(AuthController.to.authUser?.value?.email,
                        style: TextStyle(color: Colors.black)),
                    SizedBox(height: 16),
                    /*
                    Account Section
                    */
                    FormFieldSeparator(Tr.account_details.tr),
                    TextInput(
                        name: 'name',
                        label: Tr.name.tr,
                        initialValue: AuthController.to.authUser?.value?.name,
                        icon: Icons.person_outline,
                        obscureText: false,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.maxLength(context, 50),
                        ])),
                    _getGenderTextField(context),
                    TextDateTimePicker(
                      name: 'date_of_birth',
                      label: Tr.date_of_birth.tr,
                      inputType: InputType.date,
                      icon: Icons.date_range_outlined,
                      initialValue: AuthController.to.authUser?.value?.dateOfBirth,
                      enabled:
                          AuthController.to.authUser?.value?.dateOfBirth != null ? false : true,
                      validator:
                          FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
                    ),

                    /*
                    Security Section
                    */
                    FormFieldSeparator(Tr.security.tr),
                    TextInput(
                        name: 'password',
                        label: Tr.password.tr,
                        icon: Icons.vpn_key,
                        obscureText: true,
                        enabled: AuthController.to.authUser.value.authType == AuthType.email,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.maxLength(context, 50),
                          (val) {
                            if (val != null && val.length < 8) {
                              return Tr.warning_minimum_password_length.tr;
                            }
                            return null;
                          }
                        ])),
                    TextInput(
                        name: 'confirm_password',
                        label: Tr.confirm_password.tr,
                        icon: Icons.vpn_key,
                        enabled: AuthController.to.authUser.value.authType == AuthType.email,
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.maxLength(context, 50),
                          (val) {
                            if (_formKey.currentState.fields['password']?.value != val) {
                              return Tr.warning_passwords_not_matching.tr;
                            }
                            return null;
                          }
                        ])),
                    SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: Get.width, height: 48),
                      child: ElevatedButton(
                        child: Text(Tr.update_profile.tr),
                        onPressed: () {
                          profileController.isLoading.value = true;
                          controller.updateProfile(_formKey);
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getGenderTextField(BuildContext context) {
    Gender gender = AuthController.to.authUser?.value?.gender;
    var name = "gender";
    var label = Tr.gender.tr;
    var hint = Tr.select_the_gender.tr;
    var icon = Icons.attribution_outlined;
    var items = ["male", "female"];
    var enabled = gender != null ? false : true;
    var validator = FormBuilderValidators.compose([FormBuilderValidators.required(context)]);
    if (gender != null) {
      return TextDropdown(
        name: name,
        label: label,
        hint: hint,
        icon: icon,
        initialValue: gender.toShortString(),
        items: items,
        enabled: enabled,
        validator: validator,
      );
    } else {
      return TextDropdown(
          name: name,
          label: label,
          hint: hint,
          icon: icon,
          items: items,
          enabled: enabled,
          validator: validator);
    }
  }
}
