import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/decoration.dart';
import 'package:transparent/utils/string_files.dart';
import 'package:transparent/utils/text_style.dart';
import 'package:transparent/widgets/decorations.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List dataList = [];
  List mainList = [];
  var productCollections;
  var productDocument;
  var collection;
  var document;

  dataGet() async {
    collection = FirebaseFirestore.instance.collection("users");
    document = await collection.doc("fk09855@gmail.com").get();
    if (document.exists) {
      var data = document.data();
      setState(() {
        dataList.addAll(data["data"]["cart"]);
      });
    }

    productCollections = FirebaseFirestore.instance.collection("products");

    productDocument = await productCollections.doc("6").get();

    if (productDocument.exists) {
      var data2 = productDocument.data();
      data2["data"].forEach((ele) {
        if (dataList.contains(ele["id"])) {
          mainList.add(ele);
        }
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    dataGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body(mainList));
  }
}

_appBar() {
  return AppBar(
    centerTitle: true,
    title: const Text(StringFiles.cart),
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: ColorsUtils.textBlack,
  );
}

_body(mainList) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount: mainList.length,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return CartTile(
        isVisible: true,
        data: mainList[index],
      );
    },
  );
}

class CartTile extends StatelessWidget {
  CartTile({Key? key, required this.isVisible, required this.data})
      : super(key: key);

  ValueNotifier<int> quantity = ValueNotifier<int>(1);
  final bool isVisible;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tileImage(context),
          verticalLine(),
          priceDetails(context),
          const Spacer(),
          deleteButton(),
        ],
      ),
    );
  }

  tileImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(data["imgUrl"]),
      ),
    );
  }

  verticalLine() {
    return Container(
      width: 0.3,
      height: 80,
      color: Colors.grey.shade400,
    );
  }

  priceDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(data["name"], FontWeight.w600, 17),
          const SizedBox(height: 4),
          CustomText(data["price"], FontWeight.w500, 14),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundContainerButton(
                child: const Icon(Icons.remove, size: 12, color: Colors.white),
                onTap: () {
                  quantity.value -= 1;
                },
              ),
              RoundContainerButton(
                  isBorder: true,
                  onTap: () {},
                  child: ValueListenableBuilder(
                    builder: (context, value, child) {
                      return CustomText("$value", FontWeight.w500, 11);
                    },
                    valueListenable: quantity,
                  )),
              RoundContainerButton(
                  onTap: () {
                    quantity.value += 1;
                  },
                  child: const Icon(Icons.add, size: 12, color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  deleteButton() {
    return ClipPath(
      clipper: CustomClip(),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          color: ColorsUtils.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
