import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = [
    'Hold 1',
    'Hold 2',
    'Hold 3',
    'Hold 4',
    'Hold 5',
    'Hold 6',
  ];

  FormGroup buildForm() => fb.group({
        'selectedItems': FormControl<List<String>>(value: []),
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Widget'),
      ),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ReactiveCustomDropdown(
                  formControlName: 'selectedItems',
                  items: items,
                  hintText: 'Select Items',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReactiveCustomDropdown extends StatelessWidget {
  final String formControlName;
  final List<String> items;
  final String hintText;
  const ReactiveCustomDropdown({
    super.key,
    required this.formControlName,
    required this.items,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<List<String>, List<String>>(
      formControlName: formControlName,
      builder: (field) {
        bool hasValue = field.value?.isNotEmpty ?? false;
        Color borderColor = hasValue ? Colors.blue : Colors.grey;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                hintText,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = field.value?.contains(item) ?? false;
                      return InkWell(
                        onTap: () {
                          List<String> currentValues =
                              List<String>.from(field.value ?? []);
                          isSelected
                              ? currentValues.remove(item)
                              : currentValues.add(item);
                          field.didChange(currentValues);
                          menuSetState(() {});
                        },
                        child: Container(
                          // height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 20,
                                color: isSelected ? Colors.blue : Colors.grey,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              value: field.value?.isEmpty ?? true ? null : field.value!.last,
              onChanged: (_) {},
              selectedItemBuilder: (context) {
                final selectedItems = field.value ?? [];
                return List.generate(items.length, (index) {
                  return Text(
                    selectedItems.join(', '),
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                height: 40,
                width: double.infinity,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        );
      },
    );
  }
}
