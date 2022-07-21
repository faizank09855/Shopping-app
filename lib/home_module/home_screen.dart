import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent/login_module/login_screen.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/session_file.dart';
import '../payment_widgets.dart';
import '../product_description_screen.dart';
import '../utils/string_files.dart';
import '../utils/text_style.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List list = [];

  getCartList(context) async {
    String email = "fk09855@gmail.com";
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      list.addAll(data?["data"]['cart']);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: ColorsUtils.red, content: Text(StringFiles.noUser)));
    }
  }

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
          height: 250,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
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
                                          .data()["data"][index],
                                    )));
                      },
                      child: Container(
                        height: 200,
                        width: 130,
                        margin: const EdgeInsets.all(16),
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
                                        StringFiles.newString,
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
                                            color: ColorsUtils.orangeAccent,
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
          height: 250,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
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
                                          .data()["data"][index],
                                    )));
                      },
                      child: Container(
                        height: 200,
                        width: 130,
                        margin: const EdgeInsets.all(16),
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

  _drawer(context) {
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
              child: Image.network(StringFiles.demoImage)),
          CommonListTile(
              icon: Icons.account_circle_outlined, title: StringFiles.profile),
          CommonListTile(
              icon: Icons.account_balance_wallet_outlined,
              title: StringFiles.wallet),
          CommonListTile(
              icon: Icons.admin_panel_settings_outlined,
              title: StringFiles.adminPanel),
          CommonListTile(
            icon: Icons.logout,
            title: StringFiles.logout,
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(SessionFiles.isLoggedIn);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
          ),
        ],
      ),
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
                    children: [
                      CustomText("Sale", FontWeight.bold, 42,
                          color: Colors.white),
                      CustomText("Up to 40% off", FontWeight.w700, 14,
                          color: Colors.white),
                      const SizedBox(height: 16),
                      const ShopNowButton(),
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
      {Key? key, required this.title, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap:(){onTap!();},
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
