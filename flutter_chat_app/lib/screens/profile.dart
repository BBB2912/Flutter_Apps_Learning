import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(authenticatedUser.uid)
          .get(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (userSnapshot.hasError) {
          logger.i(userSnapshot.error);
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('An error occurred!')),
          );
        }
        if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('User data not found!')),
          );
        }

        final userData = userSnapshot.data;
        final imageUrl = userData!['profileImageUrl'] as String?;
        final userName = userData['userName'] as String?;
        final email = userData['email'] as String?;
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: CircleAvatar(
                    foregroundColor: Colors.amber,
                    foregroundImage: FileImage(File(imageUrl!)),
                    radius: 80,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        userName ?? 'No Name',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        email ?? 'No Email',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
