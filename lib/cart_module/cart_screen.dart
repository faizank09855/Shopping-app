import 'package:flutter/material.dart';
import 'package:transparent/utils/decoration.dart';
import 'package:transparent/utils/string_files.dart';
import 'package:transparent/utils/text_style.dart';
import 'package:transparent/widgets/decorations.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xff3d3d3d),
      ),
      body: ListView.builder(
        physics : BouncingScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CartTile();
        },
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  ValueNotifier<int> quantity = ValueNotifier<int>(1);

  CartTile({Key? key}) : super(key: key);

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
        child: Image.network(StringFiles.demoImage),
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
          CustomText(StringFiles.springRoll, FontWeight.w600, 17),
          const SizedBox(height: 4),
          CustomText(StringFiles.commonPrice, FontWeight.w500, 14),
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
                      return CustomText("${value}", FontWeight.w500, 11);
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
          color: Colors.red,
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
