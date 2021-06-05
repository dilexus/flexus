// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../../../../../_base/imports.dart';
import '../../../../../_base/screens/controllers/login_controller.dart';

class LoginSliderMaster extends GetView<LoginController> {
  final Widget child;
  final String title;
  final Function onBackPressed;
  const LoginSliderMaster({Key key, this.child, this.title, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
          child: Column(
            children: [
              SizedBox(height: 8),
              Stack(
                children: [
                  if (onBackPressed != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_rounded),
                        onPressed: onBackPressed,
                      ),
                    ),
                  Align(
                    alignment: Alignment.center,
                    heightFactor: 2,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              child
            ],
          ),
        ));
  }
}

class LoginSliders {
  static const login = 0;
  static const registration = 1;
  static const verify_email = 2;
  static const forgot_password = 3;
}
