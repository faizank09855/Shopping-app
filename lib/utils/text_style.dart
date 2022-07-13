import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text ;
  final FontWeight weight;
  final double size ;
  final Color color;

    CustomText(this.text, this.weight , this.size , {this.color = const Color(0xff3d3d3d)});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: weight, fontSize: size , color: color),
    );
  }
}
