// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_flavor/flutter_flavor.dart';

import '../_base/imports.dart' hide Translations, Bindings;
import '../_base/screens/splash/splash_screen.dart';
import 'bindings.dart';
import 'translations.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: GetMaterialApp(
        title: Config.app_name.val,
        translations: Translations(),
        locale: Locale(Config.default_language.val),
        fallbackLocale: Locale(Config.default_language.val),
        theme: ThemeData(
            primarySwatch: Config.primary_color.val,
            accentColor: Config.accent_color.val,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialBinding: Bindings(),
        debugShowCheckedModeBanner: false,
        home: FxSplashScreen(),
      ),
    );
  }
}
