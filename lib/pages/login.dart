import 'package:flutter/material.dart';
import '../widgets/customText.dart';
import '../widgets/customTextField.dart';
import '../widgets/customButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Handle login logic here
    final username = _usernameController.text;
    final password = _passwordController.text;

    debugPrint('Username: $username');
    debugPrint('Password: $password');

    // TODO: Add your login logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Map Image
          Expanded(
            child: Stack(
              children: [
                // Background Map Image
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/AgentsNearMe.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // DASH Logo at top left
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2), // Blue color
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'DASH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right Side - Login Form
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hey, Welcome text
                      const CustomText(
                        text: 'Hey, Welcome',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textColor: Color(0xFF757575), // Gray color
                      ),
                      const SizedBox(height: 8),

                      // Login heading
                      const CustomText(
                        text: 'Login',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.black,
                      ),
                      const SizedBox(height: 30),

                      // Username field
                      CustomTextField(
                        label: 'Username',
                        placeholder: 'Enter your username',
                        controller: _usernameController,
                        keyboardType: TextInputType.emailAddress,
                        borderColor: const Color(0xFFE0E0E0),
                        borderRadius: 5,
                        additionalLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      CustomTextField(
                        label: 'Password',
                        placeholder: 'Enter your password',
                        controller: _passwordController,
                        secureTextEntry: !_isPasswordVisible,
                        borderColor: const Color(0xFFE0E0E0),
                        borderRadius: 5,
                        additionalLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                        rightIcon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressRight: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'Login',
                          onPress: _handleLogin,
                          backgroundColor: const Color(0xFF1976D2), // Blue color matching DASH logo
                          height: 48,
                          borderRadius: 5,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

