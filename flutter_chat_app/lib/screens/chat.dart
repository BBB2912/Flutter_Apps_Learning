import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/auth.dart';
import 'package:flutter_chat_app/widgets/messages.dart';
import 'package:flutter_chat_app/widgets/new_message.dart';
import 'package:flutter_chat_app/widgets/side_menu.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<DocumentSnapshot> _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      _userData = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
    } on FirebaseException catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('An error occurred!')),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text('User data not found!')),
          );
        }
        final userData = snapshot.data!;
        final imageUrl = userData['profileImageUrl'] as String?;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Theme.of(context).colorScheme.primary,
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            radius: 26,
                            foregroundColor: Colors.grey,
                            foregroundImage: FileImage(File(imageUrl!)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'FlutterChat',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            drawer: SideMenu(userData: userData),
            body: Stack(
              children: [
                Messages(),
                NewMessage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
