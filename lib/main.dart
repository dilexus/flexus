// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_flavor/flutter_flavor.dart';

import 'app/bindings.dart';
import 'app/translations.dart';
import 'base/imports.dart' hide Translations, Bindings;
import 'base/screens/splash/splash_screen.dart';

void main() {
  FlavorConfig(
    //name: "DEVELOP",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: Config().get(),
  );
  Bindings().dependencies();
  runApp(Application());
}

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: GetMaterialApp(
        title: Util.to.getConfig("app_name"),
        translations: Translations(),
        locale: Locale(Util.to.getConfig("default_language")),
        fallbackLocale: Locale(Util.to.getConfig("default_language")),
        theme: ThemeData(
            primarySwatch: Util.to.getConfig("primary_color"),
            accentColor: Util.to.getConfig("accent_color"),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialBinding: Bindings(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
