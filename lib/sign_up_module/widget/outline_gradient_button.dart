import 'package:flutter/material.dart';


class OutlineGradientButton extends StatelessWidget {
  final List<Color> gradientColors;

  final String text;

  final Function onTap;

  final double textSize;
  final double radius;
  final bool isRadialGradient;

  const OutlineGradientButton(
      {Key? key,
        this.gradientColors = const [Colors.blue, Colors.lightBlue],
        this.isRadialGradient = false ,
        required this.text,
        required this.onTap,
        this.textSize = 18, this.radius = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.075,
        margin: const EdgeInsets.symmetric(horizontal:  32),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient:isRadialGradient ? RadialGradient(colors: gradientColors, radius: 12) :
            LinearGradient(colors: gradientColors,)
        ),
        width: double.infinity,
        child: InkWell(
          onTap: (){
            onTap();
          },
          child: Container(
            width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
              ),
            margin: EdgeInsets.all(1),
              child :
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.pinkAccent, fontSize: textSize),
                ),
              )
              ),
        ));
  }
}


