import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
   // Validates user credentials
   validateUser(String email, String password) async {
    try {
      emit(LoginLoading());
       final SharedPreferences prefs = await SharedPreferences.getInstance();
       final storedEmail = prefs.getString('email');
       final storedPassword = prefs.getString('password');
       if (email == storedEmail && password == storedPassword){
         emit(LoginAuthenticated());
       }else{
         emit(LoginUnAuthenticated());
       }
       return ;
   }catch(e){
      emit(LoginError(e.toString()));
    }
}}
