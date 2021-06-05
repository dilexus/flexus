// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../_base/imports.dart';
import '../../../_base/models/auth_user.dart';
import '../../../_base/widgets/form_field_separator.dart';
import '../../../_base/widgets/text_datetime_picker.dart';
import '../../../_base/widgets/text_dropdown.dart';
import '../../../_base/widgets/text_input.dart';
import '../../services/auth_service.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormBuilderState>();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Trns.profile.val)),
      body: Obx(
        () => LoadingOverlay(
          opacity: 0.0,
          isLoading: profileController.isLoading.value,
          child: Builder(builder: (context) {
            return SingleChildScrollView(
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
                      Util.to.getCircularAvatar(AuthService.to?.authUser?.value?.profilePicture,
                          AuthService.to.authUser?.value?.name, context),
                      SizedBox(height: 8),
                      Text(AuthService.to.authUser?.value?.email,
                          style: TextStyle(color: Colors.black)),
                      SizedBox(height: 16),
                      /*
                        Account Section
                        */
                      FormFieldSeparator(Trns.account_details.val),
                      TextInput(
                          name: 'name',
                          label: Trns.name.val,
                          initialValue: AuthService.to.authUser?.value?.name,
                          icon: Icons.person_outline,
                          obscureText: false,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.maxLength(context, 50),
                          ])),
                      _getGenderTextField(context),
                      TextDateTimePicker(
                        name: 'date_of_birth',
                        label: Trns.date_of_birth.val,
                        inputType: InputType.date,
                        icon: Icons.date_range_outlined,
                        initialValue: AuthService.to.authUser?.value?.dateOfBirth,
                        enabled: AuthService.to.authUser?.value?.dateOfBirth != null ? false : true,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                      ),

                      /*
                        Security Section
                        */
                      FormFieldSeparator(Trns.security.val),
                      TextInput(
                          name: 'password',
                          label: Trns.password.val,
                          icon: Icons.vpn_key,
                          obscureText: true,
                          enabled: AuthService.to.authUser.value.authType == AuthType.email,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.maxLength(context, 50),
                            (val) {
                              if (val != null && val.length < 8) {
                                return Trns.warning_minimum_password_length.val;
                              }
                              return null;
                            }
                          ])),
                      TextInput(
                          name: 'confirm_password',
                          label: Trns.confirm_password.val,
                          icon: Icons.vpn_key,
                          enabled: AuthService.to.authUser.value.authType == AuthType.email,
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.maxLength(context, 50),
                            (val) {
                              if (_formKey.currentState.fields['password']?.value != val) {
                                return Trns.warning_passwords_not_matching.val;
                              }
                              return null;
                            }
                          ])),
                      SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: Get.width, height: 48),
                        child: ElevatedButton(
                          child: Text(Trns.update_profile.val),
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
            );
          }),
        ),
      ),
    );
  }

  Widget _getGenderTextField(BuildContext context) {
    Gender gender = AuthService.to.authUser?.value?.gender;
    var name = "gender";
    var label = Trns.gender.val;
    var hint = Trns.select_the_gender.val;
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
