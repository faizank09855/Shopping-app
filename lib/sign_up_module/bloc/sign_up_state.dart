part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  final bool flag;
  SignUpLoaded({required this.flag});
}

class SignUpError extends SignUpState {
  final String error;

  SignUpError({
    required this.error,
  });
}
