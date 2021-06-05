// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../_base/base_binding.dart';
import '../_base/imports.dart';
import '../screens/home/home_controller.dart';

class Bindings extends BaseBindings {
  @override
  void dependencies() {
    super.dependencies();
    Get.put(HomeController());
  }
}
