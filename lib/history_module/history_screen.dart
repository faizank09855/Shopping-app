import 'package:flutter/material.dart';
import 'package:transparent/utils/text_style.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("History"),
        elevation: 0,
        foregroundColor: const Color(0xff3d3d3d),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: CustomText(
          "No History Available",
          FontWeight.w600,
          20,
          color: const Color(0xff6d6d6d),
        ),
      ),
    );
  }
}
