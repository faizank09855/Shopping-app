import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent/cart_module/cart_screen.dart';
import 'package:transparent/login_module/bloc/login_bloc.dart';
import 'package:transparent/login_module/login_screen.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/session_file.dart';
import '../payment_screen.dart';
import '../payment_widgets.dart';
import '../product_description_screen.dart';
import '../utils/string_files.dart';
import '../utils/text_style.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List list = [];
  bool isDialogueShowing = false;
  String? userImage;

  getCartList(context) async {
    String email = "fk09855@gmail.com";
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      list.addAll(data?["data"]['cart']);
      data?["data"]["imgUrl"];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: ColorsUtils.red, content: Text(StringFiles.noUser)));
    }
  }

  int tapTime = 0;

  @override
  Widget build(BuildContext context) {
    getCartList(context);
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: _drawer(context),
        appBar: _appBar(),
        body: _body(context),
      ),
    );
  }

  productListView(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: const TextStyle(
                color: ColorsUtils.textBlack,
                fontWeight: FontWeight.w900,
                fontSize: 14),
          ),
        ),
        SizedBox(
          height: 210,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  padding: EdgeInsets.only(left: 16),
                  itemCount: snapshot.data!.docs[0].data()["data"].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isAdded = list.contains(
                        snapshot.data!.docs[0].data()["data"][index]["id"]);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDescription(
                                    product: snapshot.data!.docs[0]
                                        .data()["data"][index])));
                      },
                      child: ItemCard(
                        imgUrl: snapshot.data!.docs[0].data()["data"][index]
                            ["imgUrl"],
                        isAdded: isAdded,
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  freshList(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: const TextStyle(
                color: Color(0xff3d3d3d),
                fontWeight: FontWeight.w900,
                fontSize: 14),
          ),
        ),
        SizedBox(
          height: 210,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: snapshot.data!.docs[0].data()["data"].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isAdded = list.contains(
                        snapshot.data!.docs[0].data()["data"][index]["id"]);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDescription(
                              product: snapshot.data!.docs[0].data()["data"]
                                  [index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 200,
                        width: 110,
                        margin: const EdgeInsets.only(
                            top: 16, bottom: 16, right: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data!.docs[0]
                                    .data()["data"][index]["imgUrl"]
                                    .toString()))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "New",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade500),
                                      ),
                                    )),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: isAdded
                                        ? const Icon(
                                            Icons.shopping_cart,
                                            color: Colors.orangeAccent,
                                          )
                                        : Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.grey.shade500,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  _drawer(BuildContext context) {
    return Drawer(
      semanticLabel: StringFiles.shoppingDrawer,
      elevation: 3,
      child: Column(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc("fk09855@gmail.com")
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return DrawerHeader(
                    margin: const EdgeInsets.all(0),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    decoration: const BoxDecoration(),
                    child: Row(
                      children: [
                        Image.network(snapshot.data!["data"]["imgUrl"]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(snapshot.data!["data"]["name"],
                                  FontWeight.w700, 22,
                                  color: ColorsUtils.textBlack),
                            ],
                          ),
                        )
                      ],
                    ));
              }
            },
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
            onTap: () {},
          ),
          CommonListTile(
            icon: Icons.logout,
            title: StringFiles.logout,
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(SessionFiles.isLoggedIn);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => LoginBloc(),
                            child: LoginScreen(),
                          )));
            },
          ),
        ],
      ),
    );
  }

  showDialogue(BuildContext context, String img) {
    showDialog(
      context: context,
      builder: (context) {
        return Listener(
          // onPointerHover: (_) {
          //   Navigator.pop(context);
          // },
          child: Container(
            child: Center(
              child: Image.network(img),
            ),
          ),
        );
      },
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs[0].data()["data"].length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (BuildContext context, int index) {
                      return CircleAvatarListTile(
                          data: snapshot.data!.docs[0].data()["data"][index]
                              ["imgUrl"]);
                    },
                  );
                }),
          ),
          ContainerLinear(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText("Sale", FontWeight.bold, 42,
                          color: Colors.white),
                      CustomText("Up to 40% off", FontWeight.w700, 14,
                          color: Colors.white),
                      SizedBox(height: 16),
                      ShopNowButton(),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: Image.asset("assets/sale.png")),
              ],
            ),
          ),
          const SizedBox(height: 16),
          productListView("Recommended For You"),
          freshList("Fresh Collection"),
        ],
      ),
    );
  }

  _appBar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 82),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            const Expanded(
              child: ShadowTextFieldGrey(
                hint: "What Are You Looking For?",
                leading: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonListTile extends StatelessWidget {
  final String title;
  final IconData icon;

  Function? onTap;

  CommonListTile(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap!();
      },
      leading: Icon(icon),
      title: CustomText(
        title,
        FontWeight.w500,
        16,
        color: ColorsUtils.textBlack,
      ),
    );
  }
}
