// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flexus/_base/screens/login/login_screen.dart';

import '../../../_base/imports.dart';
import '../../../_base/screens/profile/profile_screen.dart';
import '../../../_base/services/auth_service.dart';
import '../home_controller.dart';

class HomeDrawer extends ScreenMaster<HomeController> {
  final AuthService appController = Get.find();

  @override
  Widget create() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(Get.context).primaryColor,
            ),
            child: Center(
              child: Column(
                children: [
                  Util.to.getCircularAvatar(appController?.authUser?.value?.profilePicture,
                      appController?.authUser?.value?.name, Get.context),
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
              Get.back();
              Get.to(() => ProfileScreen());
            },
          ),
          ListTile(
            title: Text(Trns.logout.tr),
            onTap: () {
              AuthService.to.logout(LoginScreen(LoginSliders.login));
            },
          ),
        ],
      ),
    );
  }
}
