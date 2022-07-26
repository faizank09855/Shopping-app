part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpSubmitEvent extends SignUpEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String imgUrl;
  final List items;

  SignUpSubmitEvent(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.imgUrl,
      required this.items});
}
