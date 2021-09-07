import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProductData {
  late String cart_id;
  late String category;
  late String product_id;
  late int quantity;
  late ProductData productData;

  CartProductData();

  CartProductData.fromDocument(DocumentSnapshot documentSnapshot) {
    cart_id = documentSnapshot.id;
    category = documentSnapshot["category"];
    product_id = documentSnapshot["product_id"];
    quantity = documentSnapshot["quantity"];
  }

  Map<String, dynamic> topMap() {
    return {
      "category": category,
      "product_id": product_id,
      "quantity": quantity,
      //"product": productData.toResumedMap(),
    };
  }
}
