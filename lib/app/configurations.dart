// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../_base/imports.dart';
import '../screens/home/home_screen.dart';

class Configurations {
  get() => {
        Config.app_name.name: "Flexus",
        Config.home_screen.name: HomeScreen(),
        Config.default_language.name: "en",
        Config.splash_timer_seconds.name: 5,
        Config.primary_color.name: Colors.pink,
        Config.accent_color.name: Colors.pink,
      };
}

enum Config {
  app_name,
  home_screen,
  default_language,
  splash_timer_seconds,
  primary_color,
  accent_color
}
