import 'package:flutter/material.dart';
import 'package:to_do_application/screens/home_screen.dart';
import 'package:to_do_application/providers/task_provider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
      title: 'To Do App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      
    ),
  );
  }
}


