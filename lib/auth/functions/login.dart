import 'package:chat_app/chat_screens/chat_screen.dart';
import 'package:chat_app/chat_screens/chats.dart';
import 'package:chat_app/components.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

Future<void> login(context,
    {required String email, required String password}) async {
  // دالة للتحقق من صحة البريد الإلكتروني
  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  // التحقق من صحة البريد الإلكتروني قبل محاولة تسجيل الدخول
  if (!isValidEmail(email)) {
    ShowToast(
        text: 'The email address is badly formatted.',
        state: ToastStates.WARNING);
    return;
  }

  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatListScreen()));
    print(credential.user!.uid);
    token = credential.user!.uid;

    ShowToast(text: 'Logged in', state: ToastStates.SUCCESS);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ShowToast(text: 'This user not found.', state: ToastStates.WARNING);
      print('This user not found.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password.');
      ShowToast(text: 'Wrong password.', state: ToastStates.ERROR);
    } else {
      ShowToast(text: e.toString(), state: ToastStates.ERROR);
    }
  } catch (e) {
    ShowToast(text: e.toString(), state: ToastStates.ERROR);
  }
}
