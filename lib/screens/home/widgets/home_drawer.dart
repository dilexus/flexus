import '../../../base/controllers/auth_controller.dart';
import '../../../base/controllers/login_controller.dart';
import '../../../base/imports.dart';
import '../../../base/screens/profile/profile_screen.dart';

class HomeDrawer extends StatelessWidget {
  final AuthController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Column(
                children: [
                  Util.to.getCircularAvatar(appController?.authUser?.value?.profilePicture,
                      appController?.authUser?.value?.name, context),
                  SizedBox(height: 8),
                  Text(Trns.welcome_name.trParams({'name': appController?.authUser?.value?.name}),
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(Trns.profile.tr),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ProfileScreen());
            },
          ),
          ListTile(
            title: Text(Trns.logout.tr),
            onTap: () {
              LoginController.to.logout();
            },
          ),
        ],
      ),
    );
  }
}
