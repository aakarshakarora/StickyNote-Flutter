import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:StickyNote/util/notepadscreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar
        (
        title: Text("Sticky Notes"),
        centerTitle: true,



        backgroundColor: Hexcolor("#e88409"),


      ),

      body:  new NotepadScreen(),
    );
  }
}
