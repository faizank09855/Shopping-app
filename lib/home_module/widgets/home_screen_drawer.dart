import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent/admin_panel/admin_panel_screen.dart';
import 'package:transparent/login_module/bloc/login_bloc.dart';
import 'package:transparent/login_module/login_screen.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/navigator_class.dart';
import 'package:transparent/utils/session_file.dart';
import 'package:transparent/utils/string_files.dart';
import 'package:transparent/utils/text_style.dart';

import 'widgets.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  DocumentSnapshot<Map<String, dynamic>>? data;
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    data = await FirebaseFirestore.instance
        .collection('users')
        .doc("fking@gmail.com")
        .get();
    isLoading.value = false ;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: StringFiles.shoppingDrawer,
      elevation: 3,
      child: Column(
        children: [
          DrawerHeader(
            margin: const EdgeInsets.all(0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: const BoxDecoration(),
            child: ValueListenableBuilder(valueListenable: isLoading, builder: (context, bool value, child) {
              return  value ? CircularProgressIndicator() : Column(
                children: [
                  Image.network(
                    data!['data']["imgUrl"],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                            data!['data']["name"], FontWeight.w700, 22,
                            color: ColorsUtils.textBlack),
                      ],
                    ),
                  )
                ],
              );
            },) ,
          ),
          CommonListTile(
            icon: Icons.account_circle_outlined,
            title: StringFiles.profile,
            onTap: () {},
          ),
          CommonListTile(
            icon: Icons.account_balance_wallet_outlined,
            title: StringFiles.wallet,
            onTap: () {},
          ),
          CommonListTile(
            icon: Icons.admin_panel_settings_outlined,
            title: StringFiles.adminPanel,
            onTap: () {
              NavigatorClass.adminPanelScreen(context);
            },
          ),
          CommonListTile(
            icon: Icons.logout,
            title: StringFiles.logout,
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(SessionFiles.isLoggedIn);
              NavigatorClass.homeScreenReplace(context, false);
            },
          ),
        ],
      ),
    );
  }
}
