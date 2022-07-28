import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdminPanelRepository {
  Future addItemRepository(String id, String imgUrl, String name, String price);
}

class AdminPanelRepositoryImpl extends AdminPanelRepository {
  @override
  Future addItemRepository(String id, String image, String name,
      String price) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("products");
    var doc = await collectionReference.doc();
    return doc.set({
      "id": id,
      "imgUrl": image,
      "name": name,
      "price": price,
    });
  }
}
