import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../base/controllers/auth_controller.dart';
import '../../base/models/auth_user.dart';
import '../imports.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateProfile(GlobalKey<FormBuilderState> formKey) async {
    if (formKey.currentState.validate()) {
      String name = formKey.currentState.fields['name']?.value;
      String password = formKey.currentState.fields['password']?.value;
      Gender gender =
          formKey.currentState.fields['gender']?.value == "male" ? Gender.male : Gender.female;
      DateTime dateOfBirth = formKey.currentState.fields['date_of_birth']?.value;

      User user = FirebaseAuth.instance.currentUser..reload();

      if (password != null) {
        await user.updatePassword(password);
      }

      user.updateProfile(displayName: name).then((value) {
        user = FirebaseAuth.instance.currentUser
          ..reload().then((value) {
            AuthController.to.authUser.value.name = name;
            if (AuthController.to.authUser.value.gender == null ||
                AuthController.to.authUser.value.dateOfBirth == null) {
              AuthController.to
                  .updateUser(AuthController.to.authUser.value.uuid, gender, dateOfBirth);
              if (gender != null) AuthController.to.authUser.value.gender = gender;
              if (dateOfBirth != null) AuthController.to.authUser.value.dateOfBirth = dateOfBirth;
            }
            isLoading.value = false;
            Get.back();
          });
      });
    } else {
      isLoading.value = false;
      Util.to.logger().e("Validation Failed");
    }
  }
}
