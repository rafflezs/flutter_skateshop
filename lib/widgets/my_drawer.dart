import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

//Import de arquivos internos
import '../tiles/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  final PageController _pageController;
  MyDrawer(this._pageController);

  Widget _drawerBgBuilder() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 179, 185, 186), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _drawerBgBuilder(),
          ListView(
              padding: const EdgeInsets.only(left: 32, top: 20, right: 32),
              children: <Widget>[
                // ignore: avoid_unnecessary_containers
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.fromLTRB(10, 10, 1, 1),
                  height: 170,
                  child: Stack(children: <Widget>[
                    const Positioned(
                      top: 30,
                      left: 0,
                      child: Text(
                        "D'Role\nSkateshop",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 3,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                !model.isLoggedIn()
                                    ? "Usuário não atenticado"
                                    : "Olá, ${model.userData["name"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!model.isLoggedIn()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  } else {
                                    model.signOut();
                                  }
                                },
                                child: Text(
                                  !model.isLoggedIn()
                                      ? "Entre ou cadastre-se"
                                      : "Sair",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                DrawerTile(Icons.home, "Destaques", _pageController, 0),
                DrawerTile(Icons.list, "Produtos", _pageController, 1),
                DrawerTile(Icons.location_on, "Nossa Loja", _pageController, 2),
                DrawerTile(
                    Icons.playlist_add_check, "Pedidos", _pageController, 3),
              ]),
        ],
      ),
    );
  }
}
