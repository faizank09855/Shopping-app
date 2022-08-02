import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent/admin_panel/admin_add_item_screen.dart';
import 'package:transparent/admin_panel/admin_panel_screen.dart';
import 'package:transparent/admin_panel/bloc/admin_bloc.dart';
import 'package:transparent/category_module/category_screen.dart';
import 'package:transparent/home_module/bottom_nav_bar.dart';
import 'package:transparent/home_module/product_description_screen.dart';
import 'package:transparent/login_module/bloc/login_bloc.dart';
import 'package:transparent/login_module/login_screen.dart';
import 'package:transparent/sign_up_module/bloc/sign_up_bloc.dart';
import 'package:transparent/sign_up_module/sign_up_screen.dart';

class NavigatorClass {
  static adminAddItemScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => AdminBloc(),
                  child: AdminAddItemScreen(),
                )));
  }

  static homeScreenReplace(BuildContext context, isLoggedIn) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => !isLoggedIn
                ? BlocProvider(
                    create: (context) => LoginBloc(),
                    child: LoginScreen(),
                  )
                : const HomeScreenBottomNavigation()));
  }

  static productDescription(BuildContext context, Map data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDescription(product: data)));
  }

  static categoryScreen(BuildContext context, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryScreen(title: title)));
  }

  static adminPanelScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminPanelScreen()));
  }

  static signInScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignUpBloc(),
            child: SignUpScreen(),
          ),
        ));
  }
}
