import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horus_travels_bloc/authentication/screens/widgets/login_widgets/login_cubit.dart';
import 'package:iconsax/iconsax.dart';
import 'custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  // Toggles password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  validate() {
    if(formKey.currentState?.validate()??false){
      BlocProvider.of<LoginCubit>(context)
          .validateUser(emailController.text, passwordController.text);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            // Email Input Field
            CTextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return "Email cannot be empty";
                }
                return null;

              },
              controller: emailController,
              labelText: 'Email',
              prefixIcon: const Icon(Iconsax.direct_right),
            ),
            const SizedBox(height: 16),

            // Password Input Field
            CTextFormField(
              validator: (value){
                if (value == null || value.isEmpty){
                  return "Password cannot be empty";
                }
                return null;
              },
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
                       await validate();
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
