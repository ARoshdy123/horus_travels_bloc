import 'package:flutter/material.dart';

import 'widgets/signup_widgets/signup_form.dart';



class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let’s create your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              const SignUpForm()
            ],
          ),
        ),
      ),
    );
  }
}