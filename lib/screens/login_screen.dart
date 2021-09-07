// ignore_for_file: deprecated_member_use

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text("Entrar"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ))
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
              key: _fromKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (text) => EmailValidator.validate(text!)
                        ? null
                        : "E-mail inválido",
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "E-mail"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    validator: (String? text) {
                      if (text!.isEmpty || text.length < 6) {
                        return "Senha inválida";
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(hintText: "Senha"),
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          _scaffoldKey.currentState!
                              .showSnackBar(const SnackBar(
                            content: Text("Insira um e-mail válido"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          model.recoverPass(_emailController.text);
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Text("Confira sua caixa de entrada"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: const Text(
                        "Esqueceu a senha?",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          if (_fromKey.currentState!.validate()) {}
                          model.signIn(
                              email: _emailController.text,
                              pass: _passwordController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        },
                        child: const Text(
                          "Entrar",
                          style: TextStyle(fontSize: 20),
                        )),
                  )
                ],
              ));
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState!.showSnackBar(const SnackBar(
      content: Text("Falha ao realizar login"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
