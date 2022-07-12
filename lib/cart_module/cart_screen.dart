import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 120,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 2),
                      spreadRadius: 0,
                      blurRadius: 6),
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(-2.5, -2.5),
                      spreadRadius: 0,
                      blurRadius: 2),
                  const BoxShadow(color: Colors.white, offset: Offset(-2, -2))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        "https://media.istockphoto.com/photos/colorful-vegetables-and-fruits-vegan-food-in-rainbow-colors-picture-id1284690585"),
                  ),
                ),
                Container(
                  width: 2,
                  height: 60,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Spring Roll",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Rs. 200.00",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 4, top: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.remove,
                                size: 12,
                                color: Colors.white,
                              ))),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              margin: const EdgeInsets.only(right: 4, top: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                  child: Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ))),
                          Container(
                              margin: const EdgeInsets.only(right: 4, top: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.add,
                                size: 12,
                                color: Colors.white,
                              ))),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                ClipPath(
                  clipper: customClip(),
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
                ),
              ],
            ))
      ]),
    );
  }
}

class customClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);

    // path.lineTo(50,  size.height);
    var controllPoint = Offset(-4, size.height);
    var endPoint = Offset(size.width + 4, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width - 2, size.height);
    var controllPoint2 = Offset(size.width + 6, -6);
    var endPoint2 = const Offset(0, 0);
    path.quadraticBezierTo(
        controllPoint2.dx, controllPoint2.dy, endPoint2.dx, endPoint2.dy);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
