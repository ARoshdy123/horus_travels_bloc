import 'package:flutter/material.dart';
import 'authentication/screens/login_screen.dart';
import 'authentication/screens/signup_screen.dart';
import 'authentication/screens/main_screen.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Horus Travels',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      initialRoute: '/login',
      routes: {
        '/signup': (context) => const SignUpScreen(), ///Navigator.pushReplacementNamed(context, '/login');
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
