// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../../../../_base/imports.dart';
import '../../../../_base/screens/controllers/auth_controller.dart';
import '../../../../_base/screens/controllers/login_controller.dart';
import '../../../../_base/screens/views/profile/profile_screen.dart';

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
