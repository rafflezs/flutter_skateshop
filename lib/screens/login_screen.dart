import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
          key: _fromKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                validator: (text) =>
                    EmailValidator.validate(text!) ? null : "E-mail inválido",
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "E-mail"),
              ),
              const SizedBox(height: 16),
              TextFormField(
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
                  onPressed: () {},
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
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          )),
    );
  }
}
