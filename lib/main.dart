import 'package:flutter/material.dart';
import 'package:networkingdemo/screens/album_photo/a_p.dart';
import 'package:networkingdemo/screens/home.dart';
import 'package:networkingdemo/screens/post_comment/p_c.dart';
import 'package:networkingdemo/screens/user_album/u_a.dart';
import 'package:networkingdemo/screens/u_a_p.dart';
import 'package:networkingdemo/screens/u_p_c.dart';
import 'package:networkingdemo/screens/user_todo/u_t.dart';

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
        '/uap': (context) => UAPScreen(),
        '/upc': (context) => UPCScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
