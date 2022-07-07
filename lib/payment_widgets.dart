import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final List<Color> gradientColors ;
  final String text ;
  final Function onTap ;
  final double textSize ;
   const GradientButton({Key? key, this.gradientColors = const[Colors.blue , Colors.lightBlue], required this.text,required this.onTap, this.textSize = 18}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.075,
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient:  RadialGradient(
                colors: gradientColors,
                radius: 12)),
        width: double.infinity,
        child: ElevatedButton(
            child:  Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: textSize),
            ),
            onPressed: () {onTap();},
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, elevation: 0)));
  }
}


class CircularCardWithPadding extends StatelessWidget {

  final Widget child ;
  const CircularCardWithPadding({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}


class ShadowTextFieldGrey extends StatelessWidget {
  final TextEditingController? controller;
  final String hint ;
  final Widget? leading ;
  const ShadowTextFieldGrey({Key? key,  this.controller,required this.hint, this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(2),
        prefixIcon: leading,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        fillColor: Colors.grey.shade200,
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        filled: true,
      ),
    );
  }
}

class PaymentScreenAppBar extends StatelessWidget {
  const PaymentScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text("Unpaid"),
      actions: const [
        CloseButton(
          color: Colors.black87,
        )
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 22),
    );
  }
}



