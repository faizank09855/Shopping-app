import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:transparent/widgets/decorations.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Column(
        children: [
          _topCard(context),
          _paymentOptions(context),
        ],
      ),
    ));
  }

  _topCard(BuildContext context) {
    return ClipPath(
      clipper: customClipper(),
      child: Container(
        padding: EdgeInsets.only(bottom: 4),
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Text("Payment Options"),
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  BlurWidget(
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                "https://media.istockphoto.com/photos/colorful-vegetables-and-fruits-vegan-food-in-rainbow-colors-picture-id1284690585",
                              ),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Vegetable . ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Qty-1",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "299.00 Rs . ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "10 % off",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ]),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 80,
                          child: const Text(
                            "in front of school , Ganj Bazar  , Flat 212 , pune  4343434 Maharashtra",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _paymentOptions(BuildContext context) {
    return Column(
      children: [
        _payTile("Google Pay", Colors.blue),
        _payTile("Phone Pe", Colors.purple),
        _payTile("PayTM", Colors.white),
        Divider(),
        _payTile("Cash On Delivery", Colors.amber),
      ],
    );
  }

  _payTile(String text, Color color) {
    return PaymentTile(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
          ),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
