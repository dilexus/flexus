import '../_base/imports.dart';

extension ExtConfig on Config {
  String get name {
    return this.toString().replaceFirst("Config.", "");
  }

  get val {
    return Util.to.getConfig(this.toString().replaceFirst("Config.", ""));
  }
}
