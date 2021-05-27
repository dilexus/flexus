// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'imports.dart';

class BaseTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          Trns.sign_in.val: 'Sign In',
          Trns.sign_up.val: 'Sign Up',
          Trns.name.val: 'Name',
          Trns.username.val: 'Username',
          Trns.email.val: 'Email',
          Trns.password.val: 'Password',
          Trns.confirm_password.val: "Confirm Password",
          Trns.dont_have_an_account.val: "Don't have an account? ",
          Trns.forgot_your_password.val: "Forgot your password? ",
          Trns.reset.val: "Reset",
          Trns.or_sign_in_with.val: "or sign in with",
          Trns.already_have_an_account.val: "Already have an account? ",
          Trns.email_is_being_verified.val:
              "Your email is being verified. Please click on the link which is sent to your email and click on Next button once you do so.",
          Trns.email_after_verified.val:
              "Thank you for verifying your email. Please click on Next to go in to the app.",
          Trns.verify_email.val: "Verify Email",
          Trns.verify.val: "Verify",
          Trns.next.val: "Next",
          Trns.logout.val: "Logout",
          Trns.reset_password.val: "Reset Password",
          Trns.welcome_name.val: "Welcome @name!",
          Trns.profile.val: "My Profile",
          Trns.update_profile.val: "Update Profile",
          Trns.account.val: "Account",
          Trns.security.val: "Security",
          Trns.male.val: "Male",
          Trns.female.val: "Female",
          Trns.warning_passwords_not_matching.val: "Password length must be 8 characters long",
          Trns.warning_minimum_password_length.val: "Password and confirm password is not matching",
          Trns.select_the_gender.val: "Select the gender",
          Trns.gender.val: "Gender",
          Trns.date_of_birth.val: "Date of Birth",
          Trns.account_details.val: "Account Details",
          Trns.ok.val: "OK",
          Trns.cancel.val: "Cancel",
          Trns.yes.val: "Yes",
          Trns.no.val: "No",
          Trns.reset_password_sent.val: "Reset password email sent to your email inbox",
          Trns.logout_confirmation.val: "Are you sure you want to logout?",
          Trns.error_no_user_found.val: "No user found for that email.",
          Trns.error_wrong_password.val: "Wrong password provided for that user.",
          Trns.error_weak_password.val: "The password provided is too weak.",
          Trns.error_account_already_exist.val: "The account already exists for that email.",
          Trns.error_account_exist_with_same_email.val:
              "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.",
          Trns.error_sign_in_failure.val: "Sign in failure",
          Trns.error_sign_up_failure.val: "Sign in failure",
          Trns.error_reset_password_failed.val: "Failed to reset the password",
          Trns.error_google_sign_in_failed.val: "Failed to sign in with Google.",
          Trns.error_facebook_sign_in_failed.val: "Failed to sign in with Facebook.",
          Trns.error_facebook_sign_in_canceled.val: "Failed to sign in with Facebook.",
        },
        'de': {
          'hello': 'Hallo Welt',
        }
      };
}

enum Trns {
  translation,
  sign_in,
  sign_up,
  name,
  username,
  email,
  password,
  confirm_password,
  dont_have_an_account,
  forgot_your_password,
  reset,
  or_sign_in_with,
  already_have_an_account,
  email_is_being_verified,
  email_after_verified,
  verify_email,
  verify,
  next,
  logout,
  reset_password,
  welcome_name,
  profile,
  update_profile,
  account,
  security,
  male,
  female,
  warning_passwords_not_matching,
  warning_minimum_password_length,
  select_the_gender,
  gender,
  date_of_birth,
  account_details,
  ok,
  cancel,
  yes,
  no,
  reset_password_sent,
  logout_confirmation,
  error_no_user_found,
  error_wrong_password,
  error_weak_password,
  error_account_already_exist,
  error_account_exist_with_same_email,
  error_sign_in_failure,
  error_sign_up_failure,
  error_reset_password_failed,
  error_google_sign_in_failed,
  error_facebook_sign_in_failed,
  error_facebook_sign_in_canceled
}

extension ExtTr on Trns {
  String get tr {
    return this.toString().tr;
  }

  String trParams([Map<String, String> params = const {}]) {
    return this.toString().trParams(params);
  }

  String get val {
    return this.toString();
  }
}

extension ExtTrn on Tr {
  String get tr {
    return this.toString().tr;
  }

  String trParams([Map<String, String> params = const {}]) {
    return this.toString().trParams(params);
  }

  String get val {
    return this.toString();
  }
}
