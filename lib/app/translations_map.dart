import '../base/base_translations.dart';
import '../base/imports.dart';

class TranslationsMap extends BaseTranslations {
  @override
  Map<String, Map<String, String>> get keys => Util.to.getTranslations(super.keys, {
        'en': {
          Tr.name.val: 'Flexus App',
        }
      });
}

enum Tr { name }
