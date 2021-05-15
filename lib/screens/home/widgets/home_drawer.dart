import '../../../base/controllers/auth_controller.dart';
import '../../../base/controllers/login_controller.dart';
import '../../../base/imports.dart';
import '../../../screens/profile/profile_screen.dart';

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
                  Text(Tr.welcome_name.trParams({'name': appController?.authUser?.value?.name}),
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(Tr.profile.tr),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ProfileScreen());
            },
          ),
          ListTile(
            title: Text(Tr.logout.tr),
            onTap: () {
              LoginController.to.logout();
            },
          ),
        ],
      ),
    );
  }
}
