import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class UserModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      _firebaseUser = user.user!;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    _firebaseUser =
        null; //Caso dê bosta, comentar essa linha e tirar o nullCheck do User
    notifyListeners();
  }

  void recoverPassword() {}

  bool isLoggedIn() {
    return _auth.currentUser == null;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_firebaseUser!.uid)
        .set(userData);
  }
}
