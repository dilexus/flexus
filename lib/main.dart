import 'package:flutter_flavor/flutter_flavor.dart';

import 'app/app_bindings.dart';
import 'base/imports.dart';
import 'base/screens/splash/splash_screen.dart';

void main() {
  FlavorConfig(
    //name: "DEVELOP",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: Config().get(),
  );
  AppBindings().dependencies();
  runApp(Application());
}

class Application extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: GetMaterialApp(
        title: Util.to.getConfig("app_name"),
        translations: TranslationsMap(),
        locale: Locale(Util.to.getConfig("default_language")),
        fallbackLocale: Locale(Util.to.getConfig("default_language")),
        theme: ThemeData(
          primaryColor: Util.to.getConfig("primary_color"),
          accentColor: Util.to.getConfig("accent_color"),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialBinding: AppBindings(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
