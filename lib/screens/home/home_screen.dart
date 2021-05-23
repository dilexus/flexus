import 'package:flutter/material.dart';

import '../../base/imports.dart';
import 'widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
