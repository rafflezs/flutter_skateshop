import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  CategoryScreen(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(documentSnapshot["title"]),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list_alt),
                )
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("products")
                  .doc(documentSnapshot.id)
                  .collection("items")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                          padding: const EdgeInsets.all(4),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                  childAspectRatio: 0.7),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductData productData = ProductData.fromDocument(
                                snapshot.data!.docs[index]);
                            productData.category = this.documentSnapshot.id;
                            return ProductTile("grid", productData);
                          }),
                      ListView.builder(
                          padding: const EdgeInsets.all(4),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductData productData = ProductData.fromDocument(
                                snapshot.data!.docs[index]);
                            productData.category = this.documentSnapshot.id;
                            return ProductTile("list", productData);
                          })
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
