import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminAddItemEvent>((event, emit) async {
      emit(AdminInitial());
      emit(AdminLoadingState());
      try {
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection("products");
        var doc = await collectionReference.doc();
        var a = doc.set({
          "id": "",
          "imgUrl": event.image,
          "name": event.name,
          "price": event.price,
        });
        print(a.toString());
        emit(AdminLoadedState());
      } catch (exception) {
        emit(AdminErrorState(error: exception.toString()));
      }
    });
  }
}
