// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../_base/models/auth_user.dart';
import '../../imports.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
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
}
