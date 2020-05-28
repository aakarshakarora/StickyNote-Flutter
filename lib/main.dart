import 'package:flutter/material.dart';
import 'package:StickyNote/ui/home.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sticky Notes',
      home: new Home(),




    );


  }
}

