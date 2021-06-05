// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../_base/screens/views/login/widgets/login_slider_master.dart';
import '../../imports.dart';
import '../../services/auth_service.dart';

class LoginController extends GetxController {
  CarouselController sliderController = CarouselController();
  var isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      UserCredential userCredential;
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
        isLoading.value = false;
        AuthService.to.afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
      }
    } catch (e) {
      Util.to.logger().e(e);
      isLoading.value = false;
      Get.snackbar(Tr.app_name.tr, Trns.error_google_sign_in_failed.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      Util.to.logger().i("Use sign in was successful with email");
      Util.to.logger().i(user);
      if (user != null) {
        Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
        if (user.emailVerified) {
          AuthService.to.isEmailVerified.value = true;
          isLoading.value = false;
          AuthService.to.afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
        } else {
          await user.sendEmailVerification();
          isLoading.value = false;
          sliderController.jumpToPage(LoginSliders.verify_email);
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      _handleError(e);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(Tr.app_name.tr, Trns.error_sign_up_failure.tr,
          snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, String name) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      await user.updateDisplayName(name);
      user = FirebaseAuth.instance.currentUser
        ..reload().then((value) async {
          Util.to.logger().i("Use sign up was successful with email");
          Util.to.logger().i(user);
          if (user != null) {
            Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
            isLoading.value = false;
            if (user.emailVerified) {
              AuthService.to.isEmailVerified.value = true;
              AuthService.to.afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
            } else {
              await user.sendEmailVerification();
              sliderController.jumpToPage(LoginSliders.verify_email);
            }
          }
        });
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      _handleError(e);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(Tr.app_name.tr, Trns.error_sign_up_failure.tr,
          snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }

  Future<void> signInWithFacebook() async {
    isLoading.value = true;
    try {
      final result = await FacebookLogin().logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          AuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
          User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
          Util.to.logger().i(user);
          if (user != null) {
            Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
            isLoading.value = false;
            if (user.emailVerified) {
              AuthService.to.isEmailVerified.value = true;
              AuthService.to.afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
            } else {
              await user.sendEmailVerification();
              sliderController.jumpToPage(LoginSliders.verify_email);
            }
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          Util.to.logger().e(result.errorMessage);
          isLoading.value = false;
          Get.snackbar(Tr.app_name.tr, Trns.error_facebook_sign_in_canceled.tr,
              snackPosition: SnackPosition.BOTTOM);
          break;
        case FacebookLoginStatus.error:
          Util.to.logger().e(result.errorMessage);
          isLoading.value = false;
          Get.snackbar(Tr.app_name.tr, Trns.error_facebook_sign_in_failed.tr,
              snackPosition: SnackPosition.BOTTOM);
          break;
      }
    } on FirebaseAuthException catch (e) {
      _handleError(e);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(Tr.app_name.tr, Trns.error_sign_up_failure.tr,
          snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(Tr.app_name.tr, Trns.reset_password_sent.tr,
          snackPosition: SnackPosition.BOTTOM);
      sliderController.jumpToPage(LoginSliders.login);
    } catch (e) {
      Util.to.logger().e(e);
      Get.snackbar(Tr.app_name.tr, Trns.error_reset_password_failed.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _handleError(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        Util.to.showErrorSnackBar(Tr.app_name.tr, Trns.error_no_user_found.tr);
        break;
      case "wrong-password":
        Util.to.showErrorSnackBar(Tr.app_name.tr, Trns.error_wrong_password.tr);
        break;
      case "weak-password":
        Util.to.showErrorSnackBar(Tr.app_name.tr, Trns.error_weak_password.tr);
        break;
      case "email-already-in-use":
        Util.to.showErrorSnackBar(Tr.app_name.tr, Trns.error_account_already_exist.tr);
        break;
      case "account-exists-with-different-credential":
        Util.to.showErrorSnackBar(Tr.app_name.tr, Trns.error_account_exist_with_same_email.tr);
        break;
      default:
        Util.to.showErrorSnackBar(Tr.app_name.tr, Trns.error_sign_in_failure.tr);
    }
  }
}
