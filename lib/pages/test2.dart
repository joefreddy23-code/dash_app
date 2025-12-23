import 'package:flutter/material.dart';
import '../widgets/customText.dart';
import '../widgets/customTextField.dart';
import '../widgets/customButton.dart';

class Test2Page extends StatefulWidget {
  const Test2Page({super.key});

  @override
  State<Test2Page> createState() => _Test2PageState();
}

class _Test2PageState extends State<Test2Page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Test 1 - Widget Examples'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomText Example
            const CustomText(text: 'Custom text example'),
            // const SizedBox(height: 20),

            // Email Input Field
            CustomTextField(
              label: 'Email',
              placeholder: 'Enter your email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),

            // Password Input Field
            CustomTextField(
              label: 'Password',
              placeholder: 'Enter your password',
              controller: _passwordController,
              secureTextEntry: !_isPasswordVisible,
              rightIcon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressRight: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 30),

            // Button 1 - Primary
            CustomButton(
              text: 'Primary Button',
              onPress: () => debugPrint('Primary pressed'),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 10),

            // Button 2 - Success
            CustomButton(
              text: 'Success Button',
              onPress: () => debugPrint('Success pressed'),
              backgroundColor: Colors.green,
            ),
            const SizedBox(height: 10),

            // Button 3 - Danger
            CustomButton(
              text: 'Danger Button',
              onPress: () => debugPrint('Danger pressed'),
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
