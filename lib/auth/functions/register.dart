import 'package:chat_app/chat_screens/chat_screen.dart';
import 'package:chat_app/components.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> register(context,
    {required String email, required String password}) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    token = credential.user!.uid;

    print('success register');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatScreen()));

    print(token);

    ShowToast(text: 'Registerd Success', state: ToastStates.SUCCESS);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ShowToast(text: 'weak-password', state: ToastStates.WARNING);
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      ShowToast(text: 'Email Aleready In Use', state: ToastStates.WARNING);
    }
  } catch (e) {
    print(e);
    ShowToast(text: e.toString(), state: ToastStates.ERROR);
  }
}
