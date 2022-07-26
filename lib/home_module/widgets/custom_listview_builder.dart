import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../product_description_screen.dart';
import 'widgets.dart';

class CustomListViewBuilder extends StatelessWidget {
  final List data;
  final List favoriteList;

  const CustomListViewBuilder(
      {Key? key, required this.data, required this.favoriteList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16),
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        bool isAdded = favoriteList.contains(data[index]["id"]);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDescription(product: data[index])));
          },
          child: ItemCard(
            imgUrl: data[index]["imgUrl"],
            isAdded: isAdded,
          ),
        );
      },
    );
  }
}

class CustomStream extends StatelessWidget {
  final Function builder;
  final Stream stream;
  final Widget loadingBuilder;

  const CustomStream(
      {Key? key,
      required this.builder,
      required this.stream,
      this.loadingBuilder = const Center(child: CircularProgressIndicator())})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingBuilder;
          }

          return builder(snapshot);
        });
  }
}
