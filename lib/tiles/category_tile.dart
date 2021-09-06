import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  CategoryTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(documentSnapshot["url"], scale: 1),
      ),
      title: Text(
        documentSnapshot["title"],
        style: const TextStyle(fontSize: 20),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryScreen(documentSnapshot)));
      },
    );
  }
}
