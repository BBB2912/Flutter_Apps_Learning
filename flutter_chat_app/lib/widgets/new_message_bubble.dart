import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/auth.dart';

class NewMessageBubble extends StatelessWidget {
  const NewMessageBubble.first({
    super.key,
    required this.userImage,
    required this.userName,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  const NewMessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = false,
       userImage = null,
       userName = null;

  final bool isFirstInSequence;
  final String? userImage;
  final String? userName;
  final String message;
  final bool isMe;
  
  @override
  Widget build(BuildContext context) {
    logger.i(userName);
    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            right: isMe ? 0 : null,
            child: CircleAvatar(
              radius: 20,
              foregroundImage: FileImage(File(userImage!)),
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (userName != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Text(
                        userName!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 23)
                          : Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(10),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(10),
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Text(
                      message,
                      style: TextStyle(
                        height: 1.3,
                        color: isMe
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Colors.black12,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
