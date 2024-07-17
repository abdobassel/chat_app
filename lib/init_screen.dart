import 'package:chat_app/auth/login_screen.dart';
import 'package:chat_app/chat_screens/chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // فحص إذا كان المستخدم قد سجل دخوله بالفعل
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // إذا كان مسجل دخوله، فانتقل إلى شاشة الشاتات مباشرة
      return ChatListScreen();
    } else {
      // إذا لم يكن مسجل دخوله، فانتقل إلى شاشة تسجيل الدخول
      return LoginScreen();
    }
  }
}
