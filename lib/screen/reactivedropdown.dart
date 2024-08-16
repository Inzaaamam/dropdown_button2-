import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveCustomDropdown extends StatelessWidget {
  final FormControl<List<String>> formControl;
  final List<String> items;
  final String? hintText;
  final Color borderColorTop;
  final Color borderColorBottom;
  final Color borderColorLeft;
  final Color borderColorRight;
  final double borderWidthTop;
  final double borderWidthBottom;
  final double borderWidthLeft;
  final double borderWidthRight;
  final String hint;

  const ReactiveCustomDropdown({
    super.key,
    required this.formControl,
    required this.items,
    this.hintText,
    this.borderColorTop = Colors.transparent,
    this.borderColorBottom = Colors.transparent,
    this.borderColorLeft = Colors.transparent,
    this.borderColorRight = Colors.transparent,
    this.borderWidthTop = 0.0,
    this.borderWidthBottom = 0.0,
    this.borderWidthLeft = 0.0,
    this.borderWidthRight = 0.0,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: borderColorTop,
                width: borderWidthTop,
              ),
              bottom: BorderSide(
                color: borderColorBottom,
                width: borderWidthBottom,
              ),
              left: BorderSide(
                color: borderColorLeft,
                width: borderWidthLeft,
              ),
              right: BorderSide(
                color: borderColorRight,
                width: borderWidthRight,
              ),
            ),
          ),
          child: ReactiveDropdownField<List<String>>(
            formControl: formControl,
            isExpanded: true,
            hint: Text(
              formControl.value?.isEmpty ?? true
                  ? hint
                  : formControl.value?.join(', ') ?? hint,
              style: TextStyle(
                color: formControl.value?.isEmpty ?? true
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
            iconSize: 16,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(10, 10, 6, 12),
            ),
            items: items.map((String value) {
              return DropdownMenuItem<List<String>>(
                value: [value],
                child: StatefulBuilder(
                  builder: (context, setState) {
                    final isSelected =
                        formControl.value?.contains(value) ?? false;
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(value),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isChecked) {
                        final currentValue = formControl.value ?? [];
                        if (isChecked ?? false) {
                          currentValue.add(value);
                        } else {
                          currentValue.remove(value);
                        }
                        formControl.value = List.from(currentValue);
                        setState(() {});
                      },
                    );
                  },
                ),
              );
            }).toList(),
            onChanged: (_) {},
            selectedItemBuilder: (BuildContext context) {
              return items.map((String value) {
                return Text(
                  formControl.value?.isEmpty ?? true
                      ? hintText ?? ''
                      : formControl.value!.join(', '),
                  style: TextStyle(
                    color:
                        formControl.value == null || formControl.value!.isEmpty
                            ? Colors.grey
                            : Colors.black,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }
}
