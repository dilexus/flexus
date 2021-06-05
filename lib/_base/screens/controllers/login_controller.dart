// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../_base/models/auth_user.dart';
import '../../../_base/screens/views/login/login_screen.dart';
import '../../../_base/screens/views/login/widgets/login_slider_master.dart';
import '../../imports.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  CarouselController sliderController = CarouselController();
  var isLoading = false.obs;

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
        AuthController.to.isEmailVerified.value = false;
        AuthController.to.authUser = AuthUser().obs;
        Util.to.logger().i("User logged out");
      });
    }
  }

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
        Util.to.setAuthUserDetails(AuthController.to.authUser.value, user);
        isLoading.value = false;
        afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
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
        Util.to.setAuthUserDetails(AuthController.to.authUser.value, user);
        if (user.emailVerified) {
          AuthController.to.isEmailVerified.value = true;
          isLoading.value = false;
          afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
        } else {
          await user.sendEmailVerification();
          isLoading.value = false;
          LoginController.to.sliderController.jumpToPage(LoginSliders.verify_email);
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
      user.updateProfile(displayName: name).then((value) {
        user = FirebaseAuth.instance.currentUser
          ..reload().then((value) async {
            Util.to.logger().i("Use sign up was successful with email");
            Util.to.logger().i(user);
            if (user != null) {
              Util.to.setAuthUserDetails(AuthController.to.authUser.value, user);
              isLoading.value = false;
              if (user.emailVerified) {
                AuthController.to.isEmailVerified.value = true;
                afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
              } else {
                await user.sendEmailVerification();
                LoginController.to.sliderController.jumpToPage(LoginSliders.verify_email);
              }
            }
          });
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
            Util.to.setAuthUserDetails(AuthController.to.authUser.value, user);
            isLoading.value = false;
            if (user.emailVerified) {
              AuthController.to.isEmailVerified.value = true;
              afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
            } else {
              await user.sendEmailVerification();
              LoginController.to.sliderController.jumpToPage(LoginSliders.verify_email);
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
      LoginController.to.sliderController.jumpToPage(LoginSliders.login);
    } catch (e) {
      Util.to.logger().e(e);
      Get.snackbar(Tr.app_name.tr, Trns.error_reset_password_failed.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> afterLogin() async {
    User user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> userData = await AuthController.to.getUser(user.uid);
    if (userData['gender'] != null)
      AuthController.to.authUser.value.gender =
          userData['gender'] == "male" ? Gender.male : Gender.female;
    if (userData['dateOfBirth'] != null)
      AuthController.to.authUser.value.dateOfBirth = userData['dateOfBirth'].toDate();
    Util.to.logger().d("Login Success");
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
