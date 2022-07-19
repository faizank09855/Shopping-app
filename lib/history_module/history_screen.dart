import 'package:flutter/material.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/string_files.dart';
import 'package:transparent/utils/text_style.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(StringFiles.history),
        elevation: 0,
        foregroundColor: ColorsUtils.textBlack,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: CustomText(
          StringFiles.noHistory,
          FontWeight.w600,
          20,
          color: const Color(0xff6d6d6d),
        ),
      ),
    );
  }
}
