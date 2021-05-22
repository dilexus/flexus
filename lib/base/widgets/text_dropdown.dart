import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../base/imports.dart';

class TextDropdown extends StatelessWidget {
  final String name;
  final String label;
  final String hint;
  final IconData icon;
  final bool allowClear;
  final List<String> items;
  final bool enabled;
  final String initialValue;
  final FormFieldValidator<String> validator;

  const TextDropdown(
      {Key key,
      this.name,
      this.label,
      this.hint,
      this.icon,
      this.allowClear = false,
      this.items,
      this.enabled = true,
      this.validator,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: FormBuilderDropdown(
        name: name,
        initialValue: initialValue,
        decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.all(16),
            border: new OutlineInputBorder(borderSide: new BorderSide()),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            )),
        allowClear: allowClear,
        hint: Text(hint),
        validator: validator,
        enabled: enabled,
        items: items
            .map((val) => DropdownMenuItem(
                  value: val,
                  child: Text(Trns.values
                      .firstWhere((f) => f.toString() == "Trns.$val", orElse: () => null)
                      .tr),
                ))
            .toList(),
      ),
    );
  }
}
