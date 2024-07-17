import 'package:chat_app/assets.dart';
import 'package:chat_app/chat_screens/chat_screen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['email'] !=
              FirebaseAuth.instance.currentUser!.email) {
            setState(() {
              users.add(UserModel.fromMap(element.data()));
            });
          }
        });
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatScreen(usermodel: users[index]);
              }));
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(
                    AssetClass.logo,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  users[index].name,
                  style: TextStyle(height: 1.3),
                ),
                Spacer(),
                Text(
                  users[index].email,
                  style: TextStyle(height: 1.3),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
