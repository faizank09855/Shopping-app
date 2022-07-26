import 'package:flutter/material.dart';
import 'package:transparent/login_module/widget/widgets.dart';
import 'package:transparent/payment_module/payment_widgets.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/string_files.dart';

class EmailForm extends StatelessWidget {
 final TextEditingController textController;
 final PageController controller;
  const EmailForm({Key? key,required this.textController,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: LoginTextField(
            hint: StringFiles.enterYourEmail,
            controller: textController,
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
        )
      ],
    );
  }
}
