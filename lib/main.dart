import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication/screens/login_screen.dart';
import 'authentication/screens/signup_screen.dart';
import 'authentication/screens/main_screen.dart';
import 'package:horus_travels_bloc/bloc/theme_cubit.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Horus Travels',
            theme: themeState.themeData,
            initialRoute: '/login',
            routes: {
              '/signup': (context) => const SignUpScreen(),
              '/login': (context) => const LoginScreen(),
              '/main': (context) => const MainScreen(),
            },
          );
        },
      ),
    );
  }
}
