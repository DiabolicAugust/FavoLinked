import 'package:favo_link/screens/page/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginService {
  signIn(String email, String password, BuildContext context) async {
    try {
     await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(
          e.message.toString(),
        ),
      ));
    }
  }


  signUp(String email, String password, BuildContext context) async {
    try{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(
          e.message.toString(),
        ),
      ));
    }
  }
}
