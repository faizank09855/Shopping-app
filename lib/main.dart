import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent/payment_module/payment_screen.dart';
import 'notifiacation.dart';
import 'utils/navigator_class.dart';
import 'utils/session_file.dart';
import 'utils/string_files.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));
  await PushNotificationService().setupInteractedMessage();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
        cardTheme: const CardThemeData(color: Colors.white),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.white)),
    home: const SplashScreen(),
  ));

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }

  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken.toString());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: _appBar(),
        body: _body());
  }

  _get() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (co) => const PaymentScreen(),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(StringFiles.demoImage),
            ),
            Text(
              "Faizan Khan",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leadingWidth: 72,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.arrow_back),
      ),
      actions: [
        FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () {},
            child: const Icon(Icons.share)),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(StringFiles.demoImage))),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      _get(),
                      _get(),
                      _get(),
                      _get(),
                      _get(),
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    getLoggedInStatus();
    Future.delayed(const Duration(seconds: 2),
        () => NavigatorClass.homeScreenReplace(context, isLoggedIn));
    super.initState();
  }

  Future<void> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(SessionFiles.isLoggedIn) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
