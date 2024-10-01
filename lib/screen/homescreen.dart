import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
// here is the reactive CustomWidget here 
// import 'package:flutter/material.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   FormGroup buildForm() => fb.group({
//         'dateTime': FormControl<DateTime>(value: DateTime.now()),
//       });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Time Picker in Reactive Form'),
//       ),
//       body: ReactiveFormBuilder(
//         form: buildForm,
//         builder: (context, form, child) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(16),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ReactiveTimePickerField(
//                       formControlName: 'dateTime',
//                       hintText: 'Select Date and Time',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class ReactiveTimePickerField extends StatelessWidget {
//   final String formControlName;
//   final String hintText;
//   const ReactiveTimePickerField({
//     super.key,
//     required this.formControlName,
//     required this.hintText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ReactiveFormField<DateTime, DateTime>(
//       formControlName: formControlName,
//       builder: (field) {
//         return GestureDetector(
//             onTap: () {
//               field.control.markAsTouched();
//             },
//             child: SizedBox(
//               width: double.infinity,
//               child: TimePickerSpinnerPopUp(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 minTime: DateTime.utc(1950),
//                 maxTime: DateTime.utc(2025),
//                 minuteInterval: 1,
//                 mode: CupertinoDatePickerMode.dateAndTime,
//                 barrierColor: Colors.black12,
//                 cancelText: 'Cancel',
//                 confirmText: 'OK',
//                 pressType: PressType.singlePress,
//                 radius: 10,
//                 timeFormat: 'dd/MM/yyyy HH:mm',
//                 initTime: field.value ?? DateTime.now(),
//                 onChange: (selectedDateTime) {
//                   field.didChange(selectedDateTime);
//                 },
//               ),
//             ));
//       },
//     );
//   }
// }
