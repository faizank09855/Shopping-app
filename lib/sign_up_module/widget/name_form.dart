import 'package:flutter/material.dart';
import 'package:transparent/login_module/widget/widgets.dart';
import 'package:transparent/payment_module/payment_widgets.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/string_files.dart';

import 'outline_gradient_button.dart';

class NameForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final PageController controller;
  const NameForm({Key? key, required this.firstNameController, required this.lastNameController, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: LoginTextField(
          hint: StringFiles.firstName,
          controller: firstNameController,
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: LoginTextField(
          hint: StringFiles.lastName,
          controller: lastNameController,
        ),
      ),
      GradientButton(
        text: StringFiles.next,
        onTap: () {
          controller.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
        radius: 32,
        gradientColors: const [
          ColorsUtils.orangeAccent,
          ColorsUtils.pink,
        ],
      ) ,
      OutlineGradientButton(
        text: StringFiles.back,
        onTap: () {
          controller.previousPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
        radius: 32,
        gradientColors: const [
          ColorsUtils.orangeAccent,
          ColorsUtils.pink,
        ],
      )


    ]);
  }
}
