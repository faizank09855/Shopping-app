import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/nuemorphic_box.dart';
import 'package:transparent/utils/text_style.dart';

import '../utils/string_files.dart';

class ProductDescription extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(3, 3),
                          blurRadius: 4,
                          spreadRadius: 1,
                          color: Colors.grey.shade200),
                      BoxShadow(
                          offset: const Offset(-3, -3),
                          blurRadius: 4,
                          spreadRadius: 1,
                          color: Colors.grey.shade100),
                      const BoxShadow(
                          offset: Offset(-2, -2), color: Colors.white),
                    ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      product["imgUrl"],
                      fit: BoxFit.contain,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${product["name"]}",
                        style: const TextStyle(
                            color: Color(0xff3d3d3d),
                            fontSize: 24,
                            fontWeight: FontWeight.w700)),
                    Text("\$ ${product["price"]}",
                        style: const TextStyle(
                            color: Color(0xff3d3d3d),
                            fontSize: 24,
                            fontWeight: FontWeight.w700))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(StringFiles.demoParagraph),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(StringFiles.colors,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                            ),
                            Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  shape: BoxShape.circle,
                                  border: false
                                      ? Border.all(
                                          width: 2, color: Colors.black)
                                      : null),
                            ),
                            Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  border: false
                                      ? Border.all(
                                          width: 2, color: Colors.black)
                                      : null),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(StringFiles.quantity,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            NeuMorphicBox(icon:const Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.black87,
                            ), onTap:(){}),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("1",
                                  style: TextStyle(
                                      color: Color(0xff3d3d3d),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            NeuMorphicBox(icon:const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.black87,
                            ), onTap:(){}),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
            height: 45,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    StringFiles.proceedToCheckout,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.arrow_forward, size: 20, color: Colors.white)
                ],
              ),
              onPressed: () {},
              color: Colors.transparent,
            )));
  }

  _appBar(BuildContext context) {
    return PreferredSize(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NeuMorphicBox(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.redAccent,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Center(
                child: CustomText(StringFiles.shopping, FontWeight.w500, 16,
                    color: ColorsUtils.textBlack),
              ),
              NeuMorphicBox(
                icon:  const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.redAccent,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      preferredSize: const Size(double.infinity, 64),
    );
  }
}
