import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent/payment_widgets.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(child:  PaymentScreenAppBar(), preferredSize: Size( double.infinity ,65 ,)) ,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                  "https://media.istockphoto.com/photos/colorful-vegetables-and-fruits-vegan-food-in-rainbow-colors-picture-id1284690585"),
                            )),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              const Text(
                                "Boat Rockerz 350 On Ear Bluetooth Headphone",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black54,
                                                offset: Offset(1, 2),
                                                spreadRadius: 0.1,
                                                blurRadius: 1),
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(3),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.red,
                                                Colors.black
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight)),
                                    ),
                                    const Text(
                                      "\$ 78.24",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.info_outline_rounded)
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Type Promo Code",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45),
                      ),
                    ),
                const ShadowTextFieldGrey(hint: "Type Promo Code",)
                  ],
                ),
              ),
            ),
          ),
          CircularCardWithPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardText("Boat Rockerz 350 Bluetooth Earphone"),
                            cardText("Tax"),
                            cardText("subtotal"),
                            cardText("Promocode"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardText("74.68"),
                            cardText("1.25"),
                            cardText("76.93"),
                            cardText("-10.93"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                    thickness: 1
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _totalText("Total"),
                      _totalText("\$ 66.93"),
                    ],
                  ),
                )
              ],
            ),
          ),
          const GradientButton(text: "Pay Now",
            gradientColors: [Colors.deepOrange, Colors.deepOrangeAccent],)
        ],
      ),
    );
  }

  cardText(text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Colors.grey.shade600,
        height: 2,
      ),
    );
  }


  _totalText(text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 21,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }
}
