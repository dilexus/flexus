import 'package:flutter/material.dart';

import '../../base/imports.dart';
import '../../screens/home/widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Tr.app_name.tr)),
      drawer: HomeDrawer(),
      body: Container(
        child: Center(
          child: Text("Welcome to ${Tr.app_name.tr}"),
        ),
      ),
    );
  }
}
