import 'package:flutter/material.dart';
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
