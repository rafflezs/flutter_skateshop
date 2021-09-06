import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData productData;

  const ProductTile(this.type, this.productData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductScreen(productData)));
      },
      child: Card(
        child: type == "grid"
            ? Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.9,
                    child: Image.network(
                      productData.url[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      children: [
                        Text(
                          productData.title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "R\$${productData.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ))
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
              )
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      productData.url[0],
                      fit: BoxFit.cover,
                      height: 200,
                      scale: 5,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productData.title,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "R\$${productData.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}
