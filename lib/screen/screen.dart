import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:task_api/screen/dio.dart';

class LoginForm extends StatelessWidget {
  final FormGroup form = FormGroup({
    'usr': FormControl<String>(validators: [Validators.required]),
    'pwd': FormControl<String>(validators: [Validators.required]),
  });
  LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: 'usr',
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  ReactiveTextField(
                    formControlName: 'pwd',
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit(BuildContext context) async {
    if (form.valid) {
      final formData = form.value;
      try {
        final apiService =
            DioHelper(baseUrl: 'http://192.168.10.120:3001/api/method/');
        // ignore: unused_local_variable
        final response = await apiService.postLogin(formData);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomeScreen()),
        // );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Sucessfully')));
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } else {
      form.markAllAsTouched();
    }
  }
}
