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
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ReactiveCustomDropdown(
                    formControlName: 'selectedItems',
                    items: items,
                    hintText: 'Select Items',
                  ),
                ),
              ],
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
              openWithLongPress: false,
              iconStyleData: IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  size: 25,
                  color: field.value?.isNotEmpty ?? false
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                useSafeArea: true,
                elevation: 0,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.5,
                      color: const Color.fromARGB(255, 222, 218, 218)),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.04),
                        blurRadius: 4,
                        spreadRadius: 2,
                        blurStyle: BlurStyle.inner),
                  ],
                ),
              ),
              autofocus: true,
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
                  enabled: true,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = field.value?.contains(item) ?? false;
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 30,
                                color: isSelected ? Colors.blue : Colors.grey,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
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
              buttonStyleData: ButtonStyleData(
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.transparent;
                    }
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.transparent;
                    }
                    if (states.contains(WidgetState.focused)) {
                      return Colors.transparent;
                    }
                    return null;
                  },
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                height: 50,
                width: double.infinity,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 50,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        );
      },
    );
  }
}
