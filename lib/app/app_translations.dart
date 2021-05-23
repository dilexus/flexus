import '../base/base_translations.dart';
import '../base/imports.dart';

class AppTranslations extends BaseTranslations {
  @override
  Map<String, Map<String, String>> get keys => Util.to.getTranslations(super.keys, {
        'en': {
          Tr.welcome.val: 'Welcome to @name',
          Tr.app_name.val: 'Flexus',
        }
      });
}

enum Tr { app_name, welcome }
