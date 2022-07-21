part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class LoginSubmit extends LoginEvent{
  final String email;
  final String password;
  final BuildContext context;
  LoginSubmit({required this.email, required this.password , required this.context});
}
