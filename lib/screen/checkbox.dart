import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:task_api/screen/reactivedropdown.dart';

class MultiSelectForm extends StatelessWidget {
  MultiSelectForm({super.key});

  final form = FormGroup({
    'selectedItems': FormControl<List<String>>(value: []),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Select Dropdown Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ReactiveCustomDropdown(
                formControl:
                    form.control('selectedItems') as FormControl<List<String>>,
                items: const [
                  'Option 1',
                  'Option 2',
                  'Option 3',
                  'Option 4',
                  'Option 5',
                  'Option 6',
                ],
                hint: 'Select options',
              ),
              const SizedBox(height: 20),
              // Display selected items below the dropdown
              ReactiveValueListenableBuilder<List<String>>(
                formControlName: 'selectedItems',
                builder: (context, control, child) {
                  if (control.value == null || control.value!.isEmpty) {
                    return const Text('No items selected');
                  }
                  return Wrap(
                    spacing: 8.0,
                    children: control.value!.map((item) {
                      return Chip(
                        label: Text(item),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
