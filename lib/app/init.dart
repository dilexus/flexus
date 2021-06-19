import 'package:firebase_core/firebase_core.dart';

import 'bindings.dart';

class Init {
  static init() {
    Bindings().dependencies();
  }

  static splashScreenInit() {
    Firebase.initializeApp();
  }

  static afterAuthentication() {}
}