// ignore_for_file: deprecated_member_use

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreenStful extends StatefulWidget {
  const SignUpScreenStful({Key? key}) : super(key: key);

  @override
  _SignUpScreenStfulState createState() => _SignUpScreenStfulState();
}

class _SignUpScreenStfulState extends State<SignUpScreenStful> {
  final _fromKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addrController = TextEditingController();
  final _cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text("Criar Conta"),
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
                    controller: _nameController,
                    validator: (String? text) {
                      if (text!.isEmpty) {
                        return "Nome inválido";
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration:
                        const InputDecoration(hintText: "Nome Completo"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addrController,
                    validator: (String? text) {
                      if (text!.isEmpty || text.length < 6) {
                        return "Endereço inválido";
                      }
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(hintText: "Endereço"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cepController,
                    validator: (String? text) {
                      if (text!.isEmpty || text.length < 8) {
                        return "CEP inválido";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "CEP"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    validator: (text) {
                      if (text!.isEmpty || !text.contains("@")) {
                        return "E-mail inválido";
                      }
                    },
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
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          if (_fromKey.currentState!.validate()) {
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "endereco": _addrController.text,
                              "cep": _cepController.text,
                              "email": _emailController.text,
                            };

                            model.signUp(
                                userData: userData,
                                pass: _passwordController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                        child: const Text(
                          "Criar Conta",
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
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
