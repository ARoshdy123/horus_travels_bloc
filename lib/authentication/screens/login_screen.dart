import 'package:flutter/material.dart';
import 'widgets/login_widgets/login_form.dart';
import 'widgets/login_widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/BGI.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                left: 16,
                right: 16,
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo, Title &subtitle
                  LoginHeader(),

                  /// Email& Password
                  LoginForm(),

                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
