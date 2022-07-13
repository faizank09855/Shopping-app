import 'package:flutter/material.dart';
import 'package:transparent/home_screen.dart';

import 'cart_module/cart_screen.dart';
import 'history_module/history_screen.dart';
import 'payment_screen.dart';

class HomeScreenBottomNavigation extends StatefulWidget {
  const HomeScreenBottomNavigation({Key? key}) : super(key: key);

  @override
  State<HomeScreenBottomNavigation> createState() =>
      _HomeScreenBottomNavigationState();
}

class _HomeScreenBottomNavigationState
    extends State<HomeScreenBottomNavigation> {
  int index = 0;

  List list = [
    HomeScreen(),
    const CartScreen(),
    const PaymentScreen() ,
    const HistoryScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        onTap: (ind) {
          setState(() {
            index = ind;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "cart" , activeIcon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(
              icon: Icon(Icons.payments_outlined),
              label: "Payment",
              activeIcon: Icon(Icons.payments_sharp)),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History" ),
        ],
      ),
    );
  }
}
