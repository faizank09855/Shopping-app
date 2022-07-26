import 'package:flutter/material.dart';
import 'package:transparent/login_module/widget/widgets.dart';
import 'package:transparent/payment_module/payment_widgets.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/string_files.dart';

import 'outline_gradient_button.dart';

class PasswordForm extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final PageController controller;
  const PasswordForm({Key? key, required this.passwordController, required this.rePasswordController, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: LoginTextField(
          hint: StringFiles.enterYourPassword,
          controller: passwordController,
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Divider(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: LoginTextField(
          hint: StringFiles.reEnterYourPassword,
          controller: rePasswordController,
        ),
      ),
      GradientButton(
        text: StringFiles.signUp,
        onTap: () {
          controller.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
        radius: 32,
        gradientColors: const [
          ColorsUtils.orangeAccent,
          ColorsUtils.pink,
        ],
      ),
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
