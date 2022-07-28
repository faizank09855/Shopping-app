import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/session_file.dart';
import 'package:transparent/widgets/loading_builder.dart';

import '../utils/string_files.dart';
import '../utils/text_style.dart';
import 'widgets/custom_listview_builder.dart';
import 'widgets/home_screen_drawer.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List list = [];
  bool isDialogueShowing = false;
  String? userImage;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  getCartList(context) async {
    var collection = _fireStore.collection('users');
    var docSnapshot = await collection.doc(SessionFiles.email).get();
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
        drawer: const HomeScreenDrawer(),
        appBar: _appBar(),
        body: _body(context),
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
            child: CustomStream(
              stream: _fireStore.collection("products").snapshots(),
              builder: (snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return CircleAvatarListTile(
                        data: snapshot.data!.docs[index]["imgUrl"]);
                  },
                );
              },
              loadingBuilder: LoadingBuilder().circleLoading(),
            ),
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
          const SizedBox(height: 8),
          horizontalList("Recommended For You"),
          gridList("Fresh Collection"),
        ],
      ),
    );
  }


  horizontalList(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomText(text, FontWeight.w900, 14,
                color: ColorsUtils.textBlack)),
        SizedBox(
          height: 210,
          child: CustomStream(
            stream: _fireStore.collection("products").snapshots(),
            builder: (AsyncSnapshot snapshot) => CustomListViewBuilder(
              data: snapshot.data!.docs,
              favoriteList: list,
            ),
            loadingBuilder: LoadingBuilder().listLoading(),
          ),
        ),
      ],
    );
  }

  gridList(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomText(text, FontWeight.w900, 14,
                color: ColorsUtils.textBlack)),
        CustomStream(
          stream: _fireStore.collection("products").snapshots(),
          builder: (AsyncSnapshot snapshot) => GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemCard(
                imgUrl: snapshot.data!.docs[index]["imgUrl"],
                isAdded: false,
              );
            },
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
          loadingBuilder: SizedBox(
              height: 100,
              child: LoadingBuilder().listLoading()),
        ),
      ],
    );
  }

  _appBar() {
    return const PreferredSize(
      preferredSize: Size(double.infinity, 82),
      child: HomeScreenAppBar(),
    );
  }
}
