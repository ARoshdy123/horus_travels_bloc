import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horus_travels_bloc/authentication/screens/home_page.dart';
import 'package:horus_travels_bloc/authentication/screens/widgets/login_widgets/login_cubit.dart';
import 'package:horus_travels_bloc/authentication/screens/widgets/main_widgets/custom_dialog.dart';
import 'widgets/login_widgets/login_form.dart';
import 'widgets/login_widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginUnAuthenticated) {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(text: "Invalid User"),
              );
            }
            if (state is LoginError) {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(text: state.errorMsg),
              );
            }
            if (state is LoginAuthenticated) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }
            // TODO: implement listener
          },
          child: Stack(
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
        ),
      ),
    );
  }
}
