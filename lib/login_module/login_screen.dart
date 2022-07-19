import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent/bottom_nav_bar.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/text_style.dart';

import '../payment_widgets.dart';
import 'widget/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: firstLayer(),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.2))),
                  ),
                  ClipPath(
                    clipper: secondLayer(),
                    child: Container(
                        decoration:
                            BoxDecoration(color: Colors.pink.withOpacity(0.3))),
                  ),
                  ClipPath(
                    clipper: thirdLayer(),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade400,
                          Colors.pinkAccent.shade100
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0, 0.4],
                      )),
                      child: const Center(
                        child: Icon(
                          Icons.verified_user,
                          size: 54,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Hello",
                    FontWeight.bold,
                    72,
                    color: ColorsUtils.textBlack,
                  ),
                  CustomText(
                    "Sign In To Your Account",
                    FontWeight.w500,
                    18,
                    color: ColorsUtils.textBlackLight,
                  ),
                  LoginTextField(
                    hint: "Enter Your Email ",
                    controller: emailController,
                  ),
                  LoginTextField(
                    hint: "Enter Your Password ",
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      CustomText(
                        "Forget Your Password?",
                        FontWeight.w500,
                        14,
                        color: ColorsUtils.textBlackLight,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: GradientButton(
                          text: 'Sign In',
                          onTap: () {
                            checkAuth(context);
                          },
                          radius: 32,
                          gradientColors: const [
                            ColorsUtils.orangeAccent,
                            ColorsUtils.pink,
                          ],
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        "Don't have an Account? ",
                        FontWeight.w300,
                        14,
                        color: ColorsUtils.textBlackLight,
                      ),
                      CustomText(
                        "Create",
                        FontWeight.w600,
                        14,
                        color: ColorsUtils.textBlack,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  checkAuth(BuildContext context) async {
    String email = emailController.text;
    String pass = passwordController.text;
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(email).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var password = data?["data"]['password'];
      if (pass == password) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeScreenBottomNavigation()));
      }
      else {
        Scaffold.of(context).showSnackBar(const SnackBar(
            backgroundColor: ColorsUtils.red, content: Text("No User Fount")));
      }
    }
    else {
      Scaffold.of(context).showSnackBar(const SnackBar(
          backgroundColor: ColorsUtils.red, content: Text("No User Fount")));
    }
  }
}

class firstLayer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    var start = Offset(40, size.height - 50);
    var end = Offset(size.width * 0.4, size.height - 50);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);

    var start2 = Offset(size.width - 70, size.height);
    var end2 = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(start2.dx, start2.dy, end2.dx, end2.dy);

    // path.lineTo(size.width, size.height );
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class secondLayer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 36);

    var start = Offset(size.width * 0.3, size.height);
    var end = Offset(size.width * 0.6, size.height - 24);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    //
    var start2 = Offset(size.width * 0.8, size.height - 48);
    var end2 = Offset(size.width, size.height - 36);
    path.quadraticBezierTo(start2.dx, start2.dy, end2.dx, end2.dy);
    //
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class thirdLayer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 42);

    var start = Offset(size.width * 0.17, size.height);
    var end = Offset(size.width * 0.35, size.height - 42);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);
    //
    var start2 = Offset(size.width * 0.6, size.height - 94);
    var end2 = Offset(size.width, size.height - 36);
    path.quadraticBezierTo(start2.dx, start2.dy, end2.dx, end2.dy);
    //
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
