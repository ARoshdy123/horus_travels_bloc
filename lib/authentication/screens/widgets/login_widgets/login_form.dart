import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  // Toggles password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Validates user credentials
  Future<bool> validateUser(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');

    return email == storedEmail && password == storedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            // Email Input Field
            CTextFormField(
              controller: emailController,
              labelText: 'Email',
              prefixIcon: const Icon(Iconsax.direct_right),
            ),
            const SizedBox(height: 16),

            // Password Input Field
            CTextFormField(
              obscureText: _obscureText,
              controller: passwordController,
              labelText: 'Password',
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            const SizedBox(height: 32),

            // Sign-In Button
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: const Color(0xFFFFFFFF),
                  backgroundColor: const Color(0xFFFFC300),
                  disabledForegroundColor: const Color(0xFFB0B0B0),
                  disabledBackgroundColor: const Color(0xFFFFE082),
                  side: const BorderSide(color: Color(0xFFFFC300)),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  final isValid = await validateUser(
                      emailController.text, passwordController.text);
                  if (isValid) {
                    Navigator.pushReplacementNamed(context, '/main');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid credentials!')),
                    );
                  }
                },
                child: const Text("Sign in"),
              ),
            ),
            const SizedBox(height: 16),

            // Create Account Button
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: const Color(0xFFFFC300),
                  side: const BorderSide(color: Color(0xFFFFC300)),
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFFC300),
                      fontWeight: FontWeight.w600),
                  padding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
