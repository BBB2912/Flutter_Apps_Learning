import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/new_message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No messages yet. Start the conversation!'),
            );
          }
          if (chatSnapshot.hasError) {
            return const Center(
              child: Text('Something went wrong. Please try again later.'),
            );
          }
          final loadedMessages = chatSnapshot.data?.docs;
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 100),
            reverse: true,
            itemCount: loadedMessages!.length,
            itemBuilder: (ctx, index) {
              final chatMessage = loadedMessages[index].data();
              final nextChatMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1].data()
                  : null;

              final currentMessageUserId = chatMessage['userId'];
              final nextMessageUserId = nextChatMessage != null
                  ? nextChatMessage['userId']
                  : null;
              final nextUserIsSame = nextMessageUserId == currentMessageUserId;

              if (nextUserIsSame) {
                return NewMessageBubble.next(
                  message: chatMessage['text'],
                  isMe: authenticatedUser.uid == currentMessageUserId,
                );
              } else {
                return NewMessageBubble.first(
                  userImage: chatMessage['userImage'],
                  userName: chatMessage['userName'],
                  message: chatMessage['text'],
                  isMe: authenticatedUser.uid == currentMessageUserId,
                );
              }
            },
          );
        },
      ),
    );
  }
}
