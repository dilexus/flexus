import 'imports.dart';

class BaseTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          Trns.app_name.val: 'Flexus',
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
        },
        'de': {
          'hello': 'Hallo Welt',
        }
      };
}

enum Trns {
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
