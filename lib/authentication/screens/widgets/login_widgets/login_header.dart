import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.only(left: 16.0),
          child: Image(
            height: 130,
            image: AssetImage("images/logo.png"),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Welcome back,",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: const Color(0xFFF1C40F),fontWeight: FontWeight.bold,),
        ),
        const SizedBox(height: 8),
        Text(
          "Discover Limitless Choices and Unmatched Convenience.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    color: const Color(0xFF73731F),),
        ),
      ],
    );
  }
}
