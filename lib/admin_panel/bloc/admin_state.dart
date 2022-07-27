part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoadingState extends AdminState {}

class AdminLoadedState extends AdminState {}

class AdminErrorState extends AdminState {
  final String error;
  AdminErrorState({required this.error});
}
