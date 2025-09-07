import 'package:flutter/material.dart';
import 'package:world_time_api/pages/home.dart';
import 'package:world_time_api/pages/loading.dart';
import 'package:world_time_api/pages/choose_location.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/loading',
    routes: {
      '/loading':(context) => const Loading(),
      '/home':(context) => Home(),
      '/choose_location':(context) => const ChooseLocation(),
    },
  ));
}

