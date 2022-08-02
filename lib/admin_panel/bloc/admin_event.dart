part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

class AdminAddItemEvent extends AdminEvent {
  final String name;
  final String price;
  final String image;
  final String category;

  AdminAddItemEvent(
      { required this.category, required this.name, required this.price, required this.image});
}
