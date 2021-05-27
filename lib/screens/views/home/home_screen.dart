// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter/material.dart';

import '../../../_base/imports.dart';
import '../../controllers/home_controller.dart';
import 'widgets/home_drawer.dart';

class HomeScreen extends AppScreen<HomeController> {
  @override
  Widget create() {
    return Scaffold(
        appBar: AppBar(title: Text(Tr.app_name.tr)),
        drawer: HomeDrawer(),
        body: Container(
          child: Center(
            child: Text(
              Tr.welcome.trParams({'name': Tr.app_name.tr}),
            ),
          ),
        ));
  }
}
