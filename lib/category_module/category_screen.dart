import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent/home_module/widgets/custom_listview_builder.dart';
import 'package:transparent/home_module/widgets/widgets.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/text_style.dart';

class CategoryScreen extends StatefulWidget {
  final String title;

  const CategoryScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: ColorsUtils.textBlack,
        centerTitle: true,
        title: CustomText(
          widget.title,
          FontWeight.w500,
          17,
          color: ColorsUtils.textBlack,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: CustomStream(
          stream: FirebaseFirestore.instance
              .collection("products")
              .where("category", isEqualTo: widget.title)
              .snapshots(),
          builder: (snapshot) {
       if(snapshot.data!.docs.length < 1 ){
         return Center(child : Text("No Data Available"));
       }
       else{
         return GridView.builder(
           padding: const EdgeInsets.all(16),
           itemCount: snapshot.data!.docs.length,
           itemBuilder: (BuildContext context, int index) {
             return GridCard(
               imgUrl: snapshot.data!.docs[index]["imgUrl"].toString(),
               isAdded: false,
             );
           },
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
           shrinkWrap: true,
         );
       }
          }),
    );
  }
}
