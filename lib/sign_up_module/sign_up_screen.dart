import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent/home_module/bottom_nav_bar.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/session_file.dart';
import 'package:transparent/utils/string_files.dart';
import 'package:transparent/utils/text_style.dart';

import 'bloc/sign_up_bloc.dart';
import 'widget/email_form.dart';
import 'widget/name_form.dart';
import 'widget/password_form.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  late List<Widget> widgetList;
  late PageController controller;
  SignUpBloc? bloc;
  late SharedPreferences prefs;

  setPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    bloc = BlocProvider.of<SignUpBloc>(context);
    setPref();
    controller = PageController(initialPage: 0);
    widgetList = [
      EmailForm(
        controller: controller,
        textController: emailController,
      ),
      NameForm(
        controller: controller,
        firstNameController: firstNameController,
        lastNameController: lastNameController,
      ),
      PasswordForm(
        controller: controller,
        passwordController: passwordController,
        rePasswordController: rePasswordController,
        onTap: () => bloc!.add(SignUpSubmitEvent(
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            password: passwordController.text,
            imgUrl: "imgUrl",
            items: [])),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoaded) {
          prefs.setBool(SessionFiles.isLoggedIn, true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreenBottomNavigation()));
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.34,
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
                          decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.3))),
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
                          stops: const [0, 0.4],
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
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomText(
                        StringFiles.signUpToYourAccount,
                        FontWeight.w500,
                        18,
                        color: ColorsUtils.textBlackLight,
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        itemCount: widgetList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              widgetList[index],
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        );
      },
    ));
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

    var start2 = Offset(size.width * 0.6, size.height - 94);
    var end2 = Offset(size.width, size.height - 36);
    path.quadraticBezierTo(start2.dx, start2.dy, end2.dx, end2.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
