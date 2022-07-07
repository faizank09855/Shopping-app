import 'package:flutter/material.dart';

import 'payment_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 82),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ShadowTextFieldGrey(
              hint: "What Are You Looking For?",
              leading: Icon(Icons.search),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                  itemCount: productTypes.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(productTypes[index]),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade400, Colors.grey.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sale",
                            style: TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text("Up to 40% off",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            width: 88,
                            child: const Center(
                              child: Text("SHOP NOW",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        ],
                      ),
                    ),
                    Expanded(flex: 2, child: Image.asset("assets/sale.png")),
                  ],
                ),
              ),
              SizedBox(height : 16),
              productListView("Recommended For You"),
              freshList("Fresh Collection"),


            ],
          ),
        ),
      ),
    );
  }

  List<String> productTypes = [
    "https://i.pinimg.com/originals/bd/ef/cb/bdefcbc72735f64db17f3250b1e64245.png",
    "https://w7.pngwing.com/pngs/972/557/png-transparent-blue-dress-shirt-t-shirt-dress-shirt-dress-shirt-tshirt-blue-image-file-formats-thumbnail.png",
    "https://cdn.imgbin.com/16/2/11/imgbin-jeans-denim-stock-photography-clothing-fly-a-stacked-pair-of-jeans-five-blue-denim-bottoms-CVybrb4QnV3B8kPmUrVScR3vY.jpg",
    "https://e7.pngegg.com/pngimages/578/823/png-clipart-black-pullover-hoodie-hoodie-t-shirt-tracksuit-bluza-jacket-hoodie-sneakers-black-thumbnail.png",
    "https://w7.pngwing.com/pngs/852/535/png-transparent-blazer-online-shopping-suit-black-clothing-blazer-fashion-black-formal-wear-thumbnail.png",
    "http://atlas-content-cdn.pixelsquid.com/stock-images/men-s-blazer-sports-coat-o0L96vF-600.jpg",
  ];



  productListView(String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(text, style: TextStyle(color: Color(0xff3d3d3d) , fontWeight: FontWeight.w900, fontSize: 14 ),),
      ),
      SizedBox(
        height: 250,
        child: ListView.builder(
          itemCount: productTypes.length,
          scrollDirection: Axis.horizontal,

          itemBuilder: (context, index) {
            return Container(
                height: 200,
                width: 130,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(productTypes[index]))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "New",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.shade500),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.grey.shade500,
                                ))),
                      ],
                    ),
                  ],
                ));
          },
        ),
      ),
    ],);
  }

  freshList(text){
    int len = productTypes.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(text, style: TextStyle(color: Color(0xff3d3d3d) , fontWeight: FontWeight.w900, fontSize: 14 ),),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: productTypes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                    height: 200,
                    width: 130,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(productTypes[(len - 1) - index]))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade500),
                                  ),
                                )),
                            Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.grey.shade500,
                                    ))),
                          ],
                        ),
                      ],
                    ));
              },
            ),
          ),
        ],);

  }
}
