import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitEvent>((event, emit)async{
   emit(SignUpInitial());
   emit(SignUpLoading());
   CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
   DocumentSnapshot doc =  await collectionReference.doc(event.email).get();
   if(doc.exists){
     emit(SignUpError(error: "Email Already Registered"));
   }
   else{
     FirebaseFirestore.instance.collection("users").doc(event.email).set({
       "data" : {
         "cart" : [""] ,
         "id" : "" ,
         "name" : "${event.firstName} ${event.lastName}" ,
         "password" : "${event.password}"
       }
     });
     emit(SignUpLoaded(flag: true));
   }

    });
  }
}
