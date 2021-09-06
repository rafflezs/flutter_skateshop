import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData productData;

  const ProductScreen(this.productData);

  @override
  _ProductScreenState createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData productData;

  _ProductScreenState(this.productData);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(productData.title),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Image.network(productData.url[0]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  productData.title,
                  /*textAlign: TextAlign.center,*/
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 24,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor)),
                    onPressed: () {},
                    child: const Text(
                      "Adcionar ao carrinho",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Descrição",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                Text(productData.description,
                    style: const TextStyle(
                        fontSize: 17, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
