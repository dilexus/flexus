// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_flavor/flutter_flavor.dart';

import '_base/imports.dart';
import 'app/app.dart';
import 'app/init.dart';

void main() {
  FlavorConfig(
    name: "Internal",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: Configurations().get(),
  );
  Init.init();
  runApp(App());
}
