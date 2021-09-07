import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product_data.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartTile extends StatelessWidget {
  final CartProductData cartProductData;

  CartTile(this.cartProductData);
  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        children: [],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProductData.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("products")
                  .doc(cartProductData.category)
                  .collection("items")
                  .doc(cartProductData.product_id)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProductData.productData =
                      ProductData.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
              })
          : _buildContent(),
    );
  }
}
