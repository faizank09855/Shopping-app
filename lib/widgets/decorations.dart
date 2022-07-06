import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWidget extends StatelessWidget {
  final Widget child;
  const BlurWidget({Key? key, required this.child}) : super(key: key , );

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaY: 4, sigmaX: 3),
    child: child,
    );
  }
}


class ImageWithChild extends StatelessWidget {
  final Widget child ;
  final String image;
  const ImageWithChild({Key? key, this.child = const SizedBox(), required this.image, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
         image,
              ),
              fit: BoxFit.cover)),

      child : child
    );
  }
}

class customClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 60);
    // path.lineTo(50,  size.height);
    var controllPoint = Offset(30, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class PaymentTile extends StatelessWidget {

  final Widget child ;
  final Color color ;
  const PaymentTile({Key? key, required this.child, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
child: child,
    );
  }
}

