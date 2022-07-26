import 'package:flutter/material.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/string_files.dart';

class CircleAvatarListTile extends StatelessWidget {
  final String data;

  const CircleAvatarListTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CircleAvatar(
        radius: 32,
        backgroundImage: NetworkImage(data.toString()),
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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.grey.shade400, Colors.grey.shade600],
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
  final String imgUrl;
  final bool isAdded;

  const ItemCard({Key? key, required this.imgUrl, required this.isAdded})
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
          image: DecorationImage(
              image: NetworkImage(imgUrl))),
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
