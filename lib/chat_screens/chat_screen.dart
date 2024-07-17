import 'package:chat_app/assets.dart';
import 'package:chat_app/auth/functions/logout.dart';
import 'package:chat_app/auth/login_screen.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.usermodel});
  final UserModel usermodel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  late final types.User _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = true;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _user = types.User(
      id: FirebaseAuth.instance.currentUser!.uid,
    );
    _loadMessages();
  }

  CollectionReference get senderMessages => _firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('chats')
      .doc(widget.usermodel.token)
      .collection('msgs');

  CollectionReference get receiverMessages => _firestore
      .collection('users')
      .doc(widget.usermodel.token)
      .collection('chats')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('msgs');

  void _loadMessages() {
    senderMessages
        .orderBy('dt', descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        return types.TextMessage(
          author: types.User(id: data?['s_id'] ?? ''),
          createdAt: data?['dt'] ?? 0,
          id: doc.id,
          text: data?['text'] ?? '',
        );
      }).toList();

      if (mounted) {
        setState(() {
          _messages.clear();
          _messages.addAll(messages);
          _isLoading = false;
        });
      }
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    if (_isSending) return; // لمنع التكرار عند إرسال الرسالة
    _isSending = true;

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Random().nextInt(100000).toString(),
      text: message.text,
    );

    final messageData = {
      's_id': FirebaseAuth.instance.currentUser!.uid,
      'r_id': widget.usermodel.token,
      'text': message.text,
      'dt': DateTime.now().millisecondsSinceEpoch,
    };

    // إضافة الرسالة إلى مجموعة المرسل
    await senderMessages.add(messageData);
    // إضافة الرسالة إلى مجموعة المستلم
    await receiverMessages.add(messageData);

    if (mounted) {
      setState(() {
        _messages.insert(0, textMessage);
      });
    }

    _isSending = false;
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
            ),
          ),
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
              'Chat',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
    );
  }
}
