import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../base/models/auth_user.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/login/widgets/login_slider_master.dart';
import '../imports.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  CarouselController sliderController = CarouselController();

  void logout() {
    FirebaseAuth.instance.signOut().then((value) {
      Get.off(LoginScreen(LoginSliders.login));
      AuthController.to.isEmailVerified.value = false;
      AuthController.to.authUser = AuthUser().obs;
      Util.to.logger().i("User logged out");
    });
  }

  Future<void> signInWithGoogle() async {
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
        afterLogin().then((value) => Get.off(() => HomeScreen()));
      }
    } catch (e) {
      Util.to.logger().e(e);
      Get.snackbar(Tr.app_name.tr, "Failed to sign in with Google.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      Util.to.logger().i("Use sign in was successful with email");
      Util.to.logger().i(user);
      if (user != null) {
        Util.to.setAuthUserDetails(AuthController.to.authUser.value, user);
        if (user.emailVerified) {
          AuthController.to.isEmailVerified.value = true;
          afterLogin().then((value) => Get.off(() => HomeScreen()));
        } else {
          await user.sendEmailVerification();
          LoginController.to.sliderController.jumpToPage(LoginSliders.verify_email);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(Tr.app_name.tr, "No user found for that email.",
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar(Tr.app_name.tr, "Wrong password provided for that user.",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, String name) async {
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
              if (user.emailVerified) {
                AuthController.to.isEmailVerified.value = true;
                afterLogin().then((value) => Get.off(() => HomeScreen()));
              } else {
                await user.sendEmailVerification();
                LoginController.to.sliderController.jumpToPage(LoginSliders.verify_email);
              }
            }
          });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(Tr.app_name.tr, "The password provided is too weak.",
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(Tr.app_name.tr, "The account already exists for that email.",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar(Tr.app_name.tr, "Sign up error.", snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final result = await FacebookLogin().logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          AuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
          User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
          Util.to.logger().i(user);
          if (user != null) {
            Util.to.setAuthUserDetails(AuthController.to.authUser.value, user);
            if (user.emailVerified) {
              AuthController.to.isEmailVerified.value = true;
              afterLogin().then((value) => Get.off(() => HomeScreen()));
            } else {
              await user.sendEmailVerification();
              LoginController.to.sliderController.jumpToPage(LoginSliders.verify_email);
            }
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          Util.to.logger().e(result.errorMessage);
          Get.snackbar(Tr.app_name.tr, "Facebook sign in cancelled",
              snackPosition: SnackPosition.BOTTOM);
          break;
        case FacebookLoginStatus.error:
          Util.to.logger().e(result.errorMessage);
          Get.snackbar(Tr.app_name.tr, "Facebook sign in error.",
              snackPosition: SnackPosition.BOTTOM);
          break;
      }
    } catch (e) {
      Util.to.logger().e(e);
      Get.snackbar(Tr.app_name.tr, "Failed to sign in with Facebook.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(Tr.app_name.tr, "Reset password email sent to your email inbox",
          snackPosition: SnackPosition.BOTTOM);
      LoginController.to.sliderController.jumpToPage(LoginSliders.login);
    } catch (e) {
      Util.to.logger().e(e);
      Get.snackbar(Tr.app_name.tr, "Failed to reset the password",
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
}
