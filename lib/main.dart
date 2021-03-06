import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

//Import de arquivos internos
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant(
        builder: (context, child, UserModel model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "D-Role Skateshop",
              theme: ThemeData(
                primaryColor: const Color.fromARGB(255, 4, 125, 141),
                primarySwatch: Colors.blue,
              ),
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
