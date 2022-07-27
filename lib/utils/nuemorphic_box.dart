import 'package:flutter/material.dart';

class NeuMorphicBox extends StatefulWidget {
  final Widget child;
  final Function onTap;

  NeuMorphicBox({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  State<NeuMorphicBox> createState() => _NeuMorphicBoxState();
}

class _NeuMorphicBoxState extends State<NeuMorphicBox> {
  bool isHold = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() {
          isHold = true;
        });
      },
      onPointerUp: (_) {
        setState(() {
          isHold = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(8),
          child: widget.child,
          decoration: isHold
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: const Offset(0, 0)),
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: const Offset(0, 0)),
                    ])
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.1,
                          blurRadius: 2,
                          offset: const Offset(2, 2)),
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.1,
                          blurRadius: 2,
                          offset: const Offset(-2, -2)),
                    ]),
          duration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
