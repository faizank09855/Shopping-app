import 'package:flutter/material.dart';
import 'package:transparent/home_module/home_screen.dart';
import '../cart_module/cart_screen.dart';
import '../history_module/history_screen.dart';
import '../payment_module/payment_screen.dart';
import '../utils/string_files.dart';

class HomeScreenBottomNavigation extends StatefulWidget {
  const HomeScreenBottomNavigation({Key? key}) : super(key: key);

  @override
  State<HomeScreenBottomNavigation> createState() =>
      _HomeScreenBottomNavigationState();
}

class _HomeScreenBottomNavigationState
    extends State<HomeScreenBottomNavigation> {
  int index = 0;
  List<Widget> list = [
    HomeScreen(),
    CartScreen(),
    const PaymentScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: list,
        index: index,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.pink.shade300,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: StringFiles.home,
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: StringFiles.cart,
              activeIcon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(
              icon: Icon(Icons.payments_outlined),
              label: StringFiles.payment,
              activeIcon: Icon(Icons.payments_sharp)),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: StringFiles.history),
        ],
      ),
    );
  }

  _onTap(ind) {
    setState(() {
      index = ind;
    });
  }
}
