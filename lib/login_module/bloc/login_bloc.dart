import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/navigator_class.dart';
import 'package:transparent/utils/session_file.dart';
import 'package:transparent/utils/string_files.dart';

import '../../home_module/bottom_nav_bar.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmit>((event, emit) async {
      emit(LoginInitial());
      emit(LoginLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = event.email;
      String pass = event.password;
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot = await collection.doc(email).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();

        var password = data?['data']['password'];

        print(pass == password);
        if (pass == password) {
          prefs.setBool(SessionFiles.isLoggedIn, true);
          prefs.setString(StringFiles.email, email);
          NavigatorClass.homeScreenReplace(event.context, true);
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              backgroundColor: ColorsUtils.red,
              content: Text(StringFiles.wrongPassword),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            backgroundColor: ColorsUtils.red,
            content: Text(StringFiles.noUser),
          ),
        );
      }
      emit(LoginLoaded());
    });
  }
}
