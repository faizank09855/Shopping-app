import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
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
        appBar: AppBar(
          leadingWidth: 72,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.arrow_back),
          ),
          actions: [
            FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {},
                child: Icon(Icons.share)),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: Center(
          child: SizedBox(
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                  child: Image.network(
                    "https://media.istockphoto.com/photos/colorful-vegetables-and-fruits-vegan-food-in-rainbow-colors-picture-id1284690585",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        children: [
                          _get(),
                          _get(),
                          _get(),
                          _get(),
                          _get(),
                          _get(),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  _get() {
    return Container(
        color: Colors.black54,
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
                  "https://media.istockphoto.com/photos/colorful-vegetables-and-fruits-vegan-food-in-rainbow-colors-picture-id1284690585"),
            ),
            Text(
              "Faizan Khan",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 12,
            ),
          ],
        ));
  }
}
