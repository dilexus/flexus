import 'package:get/get.dart';

class TranslationsMap extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          Tr.app_name.val: 'Talk To Random',
          Tr.sign_in.val: 'Sign In',
          Tr.sign_up.val: 'Sign Up',
          Tr.name.val: 'Name',
          Tr.username.val: 'Username',
          Tr.email.val: 'Email',
          Tr.password.val: 'Password',
          Tr.confirm_password.val: "Confirm Password",
          Tr.dont_have_an_account.val: "Don't have an account? ",
          Tr.forgot_your_password.val: "Forgot your password? ",
          Tr.reset.val: "Reset",
          Tr.or_sign_in_with.val: "or sign in with",
          Tr.already_have_an_account.val: "Already have an account? ",
          Tr.email_is_being_verified.val:
              "Your email is being verified. Please click on the link which is sent to your email and click on Next button once you do so.",
          Tr.email_after_verified.val:
              "Thank you for verifying your email. Please click on Next to go in to the app.",
          Tr.verify_email.val: "Verify Email",
          Tr.verify.val: "Verify",
          Tr.next.val: "Next",
          Tr.logout.val: "Logout",
          Tr.reset_password.val: "Reset Password",
          Tr.welcome_name.val: "Welcome @name!",
          Tr.profile.val: "My Profile",
          Tr.update_profile.val: "Update Profile",
          Tr.account.val: "Account",
          Tr.security.val: "Security",
          Tr.male.val: "Male",
          Tr.female.val: "Female",
          Tr.warning_passwords_not_matching.val: "Password length must be 8 characters long",
          Tr.warning_minimum_password_length.val: "Password and confirm password is not matching",
          Tr.select_the_gender.val: "Select the gender",
          Tr.gender.val: "Gender",
          Tr.date_of_birth.val: "Date of Birth",
          Tr.account_details.val: "Account Details",
        },
        'de': {
          'hello': 'Hallo Welt',
        }
      };
}

enum Tr {
  translation,
  app_name,
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
  account_details
}

extension ExtTr on Tr {
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
