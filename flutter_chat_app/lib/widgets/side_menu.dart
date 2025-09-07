import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/profile.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.userData});
  final DocumentSnapshot<Object?> userData;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final userMetaData = widget.userData.data() as Map<String, dynamic>;
    final imageUrl = userMetaData['profileImageUrl'] as String;
    final userName = userMetaData['userName'] as String;
    return Drawer(
      width: 300,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.grey,
                  foregroundImage: FileImage(File(imageUrl)),
                ),
                const SizedBox(width: 15),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>ProfileScreen()));
            },
            leading: Icon(
              Icons.person_4_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
