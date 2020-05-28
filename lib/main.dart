import 'package:flutter/material.dart';
import 'package:StickyNote/ui/home.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sticky Notes',
      home: new Home(),




    );


  }
}

