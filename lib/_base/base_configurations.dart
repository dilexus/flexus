import '../_base/imports.dart';

extension ExtConfig on Config {
  String get val {
    return this.toString();
  }

  get get {
    return Util.to.getConfig(this.toString());
  }
}
