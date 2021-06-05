// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';

class Config {
  get() => {
        "app_name": "Flexus",
        "home_screen": HomeScreen(),
        "default_language": "en",
        "splash_timer_seconds": 5,
        "primary_color": Colors.pink,
        "accent_color": Colors.pink,
      };
}
