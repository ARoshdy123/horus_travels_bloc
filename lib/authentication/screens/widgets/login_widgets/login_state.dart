part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginAuthenticated extends LoginState {}
final class LoginUnAuthenticated extends LoginState {}
final class LoginError extends LoginState {
  final String errorMsg;
  LoginError(this.errorMsg);
}
