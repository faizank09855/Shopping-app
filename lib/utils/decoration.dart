import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;

  const ShadowContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 2),
              spreadRadius: 0,
              blurRadius: 6),
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-2.5, -2.5),
              spreadRadius: 0,
              blurRadius: 2),
          const BoxShadow(color: Colors.white, offset: Offset(-2, -2))
        ]),
        child: child);
  }
}

class RoundContainerButton extends StatelessWidget {
  final Widget child;
  final bool isBorder;
  final Function onTap;

  const RoundContainerButton(
      {Key? key,
      required this.child,
      this.isBorder = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: isBorder
            ? Container(
                margin: const EdgeInsets.only(right: 4, top: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.pink.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: child))
            : Container(
                margin: const EdgeInsets.only(right: 4, top: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.pink.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: child)));
  }
}
