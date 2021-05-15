import '../../base/controllers/splash_controller.dart';
import '../../base/imports.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/logos/logo_1024.png",
            width: 200,
          ),
        ),
      ),
    );
  }
}
