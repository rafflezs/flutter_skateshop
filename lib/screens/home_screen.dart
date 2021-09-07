import 'package:flutter/material.dart';

//Import de arquivo interno
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/cart_buttom.dart';
import 'package:loja_virtual/widgets/my_drawer.dart';
import 'package:loja_virtual/tabs/products_tab.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          floatingActionButton: CartButtom(),
          body: HomeTab(),
          drawer: MyDrawer(_pageController),
        ),
        Scaffold(
          floatingActionButton: CartButtom(),
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          drawer: MyDrawer(_pageController),
          body: ProductsTab(),
        ),
        Container(color: Colors.amber),
        Container(
          color: Colors.black,
        ),
      ],
    );
  }
}
