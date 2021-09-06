import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  late String category;

  late String id;

  late String title;
  late String description;

  late double price;

  late var url;

  // late List sizes; //Depois eu implemento isso

  ProductData.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    title = documentSnapshot["title"];
    description = documentSnapshot["description"];
    price = documentSnapshot["price"].toDouble();
    url = documentSnapshot["url"];
  }
}
