import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Fazendo aquele degradezin massa
    Widget _bodyBgBuilder() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 128, 128),
              Color.fromARGB(255, 255, 182, 182)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        );

    //Retorno do widget
    return Stack(
      children: <Widget>[
        _bodyBgBuilder(),
        CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Destaques"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("home")
                  .orderBy("pos")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    staggeredTiles: snapshot.data!.docs.map((doc) {
                      return StaggeredTile.count(
                          doc["width"], doc["height"].toDouble());
                    }).toList(),
                    children: snapshot.data!.docs.map((doc) {
                      return FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: doc.get("url"),
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  );
                }
                return SliverToBoxAdapter(
                  child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
