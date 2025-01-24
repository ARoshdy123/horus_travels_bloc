import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_widgets/custom_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _obscureText = true;

  // Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Save user details to SharedPreferences
  Future<void> saveUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('phone', phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CTextFormField(
                  labelText: 'First Name',
                  prefixIcon: const Icon(Iconsax.user),
                  controller: firstNameController,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: CTextFormField(
                  labelText: 'Last Name',
                  prefixIcon: const Icon(Iconsax.user),
                  controller: lastNameController,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),

          /// Email
          CTextFormField(
            prefixIcon: const Icon(Iconsax.direct),
            labelText: 'Email',
            controller: emailController,
          ),
          const SizedBox(
            height: 16,
          ),

          /// Phone Number
          CTextFormField(
            prefixIcon: const Icon(Iconsax.call),
            labelText: 'Phone Number',
            keyboardType: TextInputType.phone,
            controller: phoneController,
          ),
          const SizedBox(
            height: 16,
          ),

          /// Password
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
          const SizedBox(
            height: 16,
          ),

          /// Signup Button
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
                await saveUserDetails(); // Save details to SharedPreferences
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Create Account'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
