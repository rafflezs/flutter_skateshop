import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product_data.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel? user;
  List<CartProductData> products = [];
  CartModel(this.user);
  bool isLoading = false;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProductData cartProductData) {
    products.add(cartProductData);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.firebaseUser!.uid)
        .collection("cart")
        .add(cartProductData.topMap())
        .then((doc) {
      cartProductData.cart_id = doc.id;
    });
    notifyListeners();
  }

  void removerCartItem(CartProductData cartProductData) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.firebaseUser!.uid)
        .collection("cart")
        .doc(cartProductData.cart_id)
        .delete();

    products.remove(cartProductData);

    notifyListeners();
  }
}
