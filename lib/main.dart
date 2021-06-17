// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_flavor/flutter_flavor.dart';

import '_base/imports.dart';
import 'app/app.dart';

void main() {
  FlavorConfig(
    //name: "DEVELOP",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: Configurations().get(),
  );
  App.init();
  runApp(App());
}
