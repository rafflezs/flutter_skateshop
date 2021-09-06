import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  CategoryTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(documentSnapshot["url"]),
      ),
      title: Text(documentSnapshot["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}
