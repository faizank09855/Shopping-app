import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'payment_widgets.dart';
import 'product_description_screen.dart';
import 'utils/string_files.dart';
import 'utils/text_style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          semanticLabel: "Shopping Drawer",
          elevation: 3,
          child: Column(
            children: [
              DrawerHeader(
                  margin: const EdgeInsets.all(0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  decoration: const BoxDecoration(),
                  child: Image.network(StringFiles.demoImage)),

              ListTile(leading: Icon(Icons.account_circle_outlined),title: CustomText("Profile" ,FontWeight.w500 ,16 ,  color: Color(0xff3d3d3d),),),
              ListTile(leading: Icon(Icons.account_balance_wallet_outlined),title: CustomText("Wallet" ,FontWeight.w500 ,16 ,  color: Color(0xff3d3d3d),),),
              ListTile(leading: Icon(Icons.admin_panel_settings_outlined),title: CustomText("Admin Panel" ,FontWeight.w500 ,16 ,  color: Color(0xff3d3d3d),),),
            ],
          ),
        ),
        appBar: PreferredSize(
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
        ),
        body: SingleChildScrollView(
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
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(snapshot
                                  .data!.docs[0]
                                  .data()["data"][index]["imgUrl"]
                                  .toString()),
                            ),
                          );
                        },
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade400, Colors.grey.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sale",
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text("Up to 40% off",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            width: 88,
                            child: const Center(
                              child: Text("SHOP NOW",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      ),
                    ),
                    Expanded(flex: 2, child: Image.asset("assets/sale.png")),
                  ],
                ),
              ),
              SizedBox(height: 16),
              productListView("Recommended For You"),
              freshList("Fresh Collection"),
            ],
          ),
        ),
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
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs[0].data()["data"].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
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
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(8),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.grey.shade500,
                                      ))),
                                ],
                              ),
                            ],
                          )),
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
            style: TextStyle(
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
                                    child: Icon(
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
}
