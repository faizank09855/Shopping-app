import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent/utils/colors_file.dart';
import 'package:transparent/utils/nuemorphic_box.dart';
import 'package:transparent/utils/text_style.dart';
import '../utils/string_files.dart';

class ProductDescription extends StatelessWidget {
  final product;

  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      drawer: const Drawer(),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: ElevatedButton(
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
          // color: Colors.transparent,
        ),
      ),
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _productImage(),
          _productNameAndPrice(),
          _productDescription(),
          _productCustomize(),
          _lowerPadding(context)
        ],
      ),
    );
  }

  _lowerPadding(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
    );
  }

  _productCustomize() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _colorOptions(),
          _quantityOptions(),
        ],
      ),
    );
  }

  _colorOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(StringFiles.colors,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.black)),
            ),
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                  border:
                      false ? Border.all(width: 2, color: Colors.black) : null),
            ),
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border:
                      false ? Border.all(width: 2, color: Colors.black) : null),
            ),
          ],
        )
      ],
    );
  }

  _quantityOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(StringFiles.quantity, FontWeight.bold, 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NeuMorphicBox(
                child: const Icon(
                  Icons.remove,
                  size: 16,
                  color: Colors.black87,
                ),
                onTap: () {}),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText("1", FontWeight.bold, 20,
                    color: Color(0xff3d3d3d))),
            NeuMorphicBox(
                child: const Icon(
                  Icons.add,
                  size: 16,
                  color: Colors.black87,
                ),
                onTap: () {})
          ],
        )
      ],
    );
  }

  _productDescription() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(StringFiles.demoParagraph),
    );
  }

  _productNameAndPrice() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText("${product["name"]}", FontWeight.w700, 24,
              color: const Color(0xff3d3d3d)),
          CustomText("\$ ${product["price"]}", FontWeight.w700, 24,
              color: const Color(0xff3d3d3d))
        ],
      ),
    );
  }

  _productImage() {
    return NeuMorphicBox(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              product["imgUrl"],
              fit: BoxFit.contain,
            )),
        onTap: () {});
  }

  _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NeuMorphicBox(
                child: const Icon(
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
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.redAccent,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
