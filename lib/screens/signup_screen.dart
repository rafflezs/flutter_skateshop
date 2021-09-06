import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text("Criar Conta"),
      ),
      body: Form(
          key: _fromKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                validator: (String? text) {
                  if (text!.isEmpty || text.length < 6) {
                    return "Nome inválido";
                  }
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: "Nome Completo"),
              ),
              const SizedBox(height: 16),
              TextFormField(
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
                validator: (String? text) {
                  if (text!.isEmpty || text.length < 8) {
                    return "CEP inválido";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "CEP Completo"),
              ),
              const SizedBox(height: 16),
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
                      "Criar Conta",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          )),
    );
  }
}
