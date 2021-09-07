import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho de compras"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int products_quantity = model.products.length;
                return Text(
                  "${products_quantity == 0 ? 0 : products_quantity.toString()} ${products_quantity == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.remove_shopping_cart_outlined,
                    size: 75,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "Realize o login para comprar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor)),
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            );
          } else if (model.products.isEmpty ||
              UserModel.of(context).isLoggedIn()) {
            return Center(
              child: Text("Nada por aqui :(",
                  style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
            );
          } else {
            return ListView(
              children: [
                Column(
                  children: model.products.map((product) {
                    return CartTile(product);
                  }).toList(),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
