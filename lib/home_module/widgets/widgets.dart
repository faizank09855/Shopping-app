import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/navigator_class.dart';
import 'package:transparent/utils/session_file.dart';
import 'package:transparent/utils/string_files.dart';
import 'package:transparent/utils/text_style.dart';

import '../../payment_module/payment_widgets.dart';

class CircleAvatarListTile extends StatelessWidget {
  final QueryDocumentSnapshot data;

  const CircleAvatarListTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              NavigatorClass.categoryScreen(context, data["name"]);
            },
            child: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(data["imgUrl"].toString()),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          CustomText(data["name"].toString(), FontWeight.w400, 14,
              color: ColorsUtils.textBlack),
        ],
      ),
    );
  }
}

class ContainerLinear extends StatelessWidget {
  final Widget child;

  const ContainerLinear({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.grey.shade400, Color(0xff9d9d9d)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: child,
    );
  }
}

class ShopNowButton extends StatelessWidget {
  const ShopNowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: 88,
      child: const Center(
        child: Text(
          StringFiles.shopNow,
          style: TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
    );
  }
}

class ItemCard extends StatelessWidget {
  final QueryDocumentSnapshot imgUrl;
  final bool isAdded;
  final int index;

  const ItemCard(
      {Key? key,
      required this.imgUrl,
      required this.isAdded,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 110,
      margin: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(imgUrl["imgUrl"]))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
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
                child: CartIconButton(isAdded: isAdded, index: index),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartIconButton extends StatefulWidget {
  final bool isAdded;
  final int index;

  const CartIconButton({Key? key, required this.isAdded, required this.index})
      : super(key: key);

  @override
  State<CartIconButton> createState() => _CartIconButtonState();
}

class _CartIconButtonState extends State<CartIconButton> {
  late bool isAdded;
  String? username;
  String? productId;

  @override
  void initState() {
    getNamePref();
    isAdded = widget.isAdded;
    getId();
    super.initState();
  }

  getId() async {
    var a = FirebaseFirestore.instance.collection("products");
    var b = await a.get();
    var map = b.docs[widget.index];
    // username = b[widget.index]
    productId = map["id"];
  }

  getNamePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString(StringFiles.email);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isAdded) {
          setState(() {
            isAdded = false;
          });
          await FirebaseFirestore.instance
              .collection("users")
              .doc(username)
              .update({
            "cart": FieldValue.arrayRemove([productId]),
          });
        } else {
          setState(() {
            isAdded = true;
          });
          await FirebaseFirestore.instance
              .collection("users")
              .doc(username)
              .update({
            "cart": FieldValue.arrayUnion([productId]),
          });
        }
      },
      child: Center(
        child: isAdded
            ?  Icon(
                Icons.shopping_cart,
                color: Colors.pink.shade300,
              )
            : Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey.shade500,
              ),
      ),
    );
  }
}

class GridCard extends StatelessWidget {
  final String imgUrl;
  final bool isAdded;

  const GridCard({Key? key, required this.imgUrl, required this.isAdded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 110,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: NetworkImage(imgUrl))),
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
    );
  }
}

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
