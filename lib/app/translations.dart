// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../_base/base_translations.dart';
import '../_base/imports.dart';

class Translations extends BaseTranslations {
  @override
  Map<String, Map<String, String>> get keys => Util.to.getTranslations(super.keys, {
        'en': {
          Tr.welcome.val: 'Welcome to @name',
          Tr.app_name.val: 'Flexus',
        }
      });
}

enum Tr { app_name, welcome }
