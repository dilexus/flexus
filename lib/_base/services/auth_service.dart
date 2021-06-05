// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexus/_base/screens/views/login/login_screen.dart';
import 'package:flexus/_base/screens/views/login/widgets/login_slider_master.dart';

import '../imports.dart';
import '../models/auth_user.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  var authUser = AuthUser().obs;
  var isEmailVerified = false.obs;

  Future<Map<String, dynamic>> getUser(String uuid) async {
    var values = new Map<String, dynamic>();
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("users").doc(uuid).get();
    if (doc.exists) {
      values['gender'] = doc['gender'];
      values['dateOfBirth'] = doc['dateOfBirth'];
    }
    return values;
  }

  Future<void> updateUser(String uuid, Gender gender, DateTime dateOfBirth) async {
    var values = new Map<String, dynamic>();
    if (gender != null) values['gender'] = gender.toShortString();
    if (dateOfBirth != null) values['dateOfBirth'] = dateOfBirth;
    await FirebaseFirestore.instance.collection("users").doc(uuid).set(values);
  }

  Future<void> afterLogin() async {
    User user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> userData = await AuthService.to.getUser(user.uid);
    if (userData['gender'] != null)
      AuthService.to.authUser.value.gender =
          userData['gender'] == "male" ? Gender.male : Gender.female;
    if (userData['dateOfBirth'] != null)
      AuthService.to.authUser.value.dateOfBirth = userData['dateOfBirth'].toDate();
    Util.to.logger().d("Login Success");
  }

  void logout() async {
    final confirmation = await showOkCancelAlertDialog(
      context: Get.context,
      title: Tr.app_name.val.tr,
      message: Trns.logout_confirmation.tr,
      okLabel: Trns.yes.tr,
      cancelLabel: Trns.no.tr,
    );
    if (confirmation == OkCancelResult.ok) {
      FirebaseAuth.instance.signOut().then((value) {
        Get.off(() => LoginScreen(LoginSliders.login));
        AuthService.to.isEmailVerified.value = false;
        AuthService.to.authUser = AuthUser().obs;
        Util.to.logger().i("User logged out");
      });
    }
  }
}
