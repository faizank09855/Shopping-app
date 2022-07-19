import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const LoginTextField({Key? key, required this.hint, required this.controller})
      : super(key: key);

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade100,
              spreadRadius: 7,
              blurRadius: 7,
              offset: const Offset(2, 2)),
          BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 7,
              blurRadius: 7,
              offset: const Offset(-2, -2)),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
