import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});


  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _enteredMessage = TextEditingController();

  @override
  void dispose() {
    _enteredMessage.dispose();
    super.dispose();
  }

  void _submitMessage() async {
     try {
    final enteredMessage = _enteredMessage.text.trim();
    if (enteredMessage.isEmpty) return;

    _enteredMessage.clear();

    final user = FirebaseAuth.instance.currentUser!;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final userData = userDoc.data() ?? {};

    await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['userName'] ?? 'Unknown',
      'userImage': userData['profileImageUrl'] ?? '',
    });
  } catch (e) {
    debugPrint('⚠️ Error sending message: $e');
  }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      right: 10,
      bottom: 20,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200, minHeight: 60),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 2,
            ),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: _enteredMessage,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    minLines: 1, // 👈 minimum height
                    maxLines: 20,
                    decoration: const InputDecoration(
                      hint: Text('Send a message...'),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 4, top: 4, left: 20),
                child: IconButton(
                  onPressed: _submitMessage,
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
