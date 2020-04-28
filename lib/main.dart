import 'package:flutter/material.dart';
import 'package:networkingdemo/screens/album_photo/album_photo.dart';
import 'package:networkingdemo/screens/home.dart';
import 'package:networkingdemo/screens/post_comment/post_comment.dart';
import 'package:networkingdemo/screens/user_album/user_album.dart';
import 'package:networkingdemo/screens/user_todo/user_todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //routes of the app
      routes: {
        '/ap': (context) => APScreen(),
        '/pc': (context) => PCScreen(),
        '/ut': (context) => UTScreen(),
        '/ua': (context) => UAScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
