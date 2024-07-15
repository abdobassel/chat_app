import 'package:chat_app/assets.dart';
import 'package:chat_app/auth/functions/logout.dart';
import 'package:chat_app/auth/login_screen.dart';
import 'package:chat_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  late final types.User _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = true; // متغير لتتبع حالة التحميل

  @override
  void initState() {
    super.initState();
    _user = types.User(
      id: FirebaseAuth.instance.currentUser!.uid,
    );
    _loadMessages();
  }

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  void _loadMessages() {
    _firestore
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data();
        return types.TextMessage(
          author: types.User(id: data['userId']),
          createdAt: data['createdAt'],
          id: doc.id,
          text: data['text'],
        );
      }).toList();

      setState(() {
        _messages.clear();
        _messages.addAll(messages); // تحديث الرسائل بعد كل استجابة من Firestore
        _isLoading = false; // تحديث حالة التحميل لإخفاء مؤشر التقدم
      });
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Random().nextInt(100000).toString(),
      text: message.text,
    );

    await _firestore.collection('messages').add({
      'userId': _user.id,
      'text': message.text,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });

    setState(() {
      _messages.insert(0, textMessage); // يُضيف الرسالة إلى بداية القائمة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorClass.backgroundColor,
        actions: [
          IconButton(
              onPressed: () async {
                await logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 30,
              ))
        ],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetClass.logo,
              height: 80,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Chat Name',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ],
        ),
      ),
      body: _isLoading // عرض مؤشر التقدم إذا كانت البيانات قيد التحميل
          ? const Center(child: CircularProgressIndicator())
          : Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
    );
  }
}
