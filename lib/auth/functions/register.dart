import 'package:chat_app/chat_screens/chat_screen.dart';
import 'package:chat_app/chat_screens/chats.dart';
import 'package:chat_app/components.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> register(context,
    {required String name,
    required String email,
    required String password}) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    token = credential.user!.uid;

    // إنشاء كائن المستخدم باستخدام نموذج UserModel
    UserModel newUser = UserModel(
      token: token,
      name: name,
      email: email,
    );

    // تخزين بيانات المستخدم في فايرستور باستخدام نموذج UserModel
    await FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .set(newUser.toMap());

    print('success register');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatListScreen()));

    print(token);

    ShowToast(text: 'Registered Success', state: ToastStates.SUCCESS);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ShowToast(text: 'weak-password', state: ToastStates.WARNING);
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      ShowToast(text: 'Email Already In Use', state: ToastStates.WARNING);
    }
  } catch (e) {
    print(e);
    ShowToast(text: e.toString(), state: ToastStates.ERROR);
  }
}
