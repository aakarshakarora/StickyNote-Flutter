import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NotepadItem extends StatelessWidget {
  String _itemName,_dateCreated;
  int _id;

  NotepadItem(this._itemName,this._dateCreated);

  NotepadItem.map(dynamic ob)
  {
    this._itemName=ob["itemName"];
    this._dateCreated=ob["dateCreated"];
    this._id=ob["id"];
  }

  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int get id => _id;


  Map<String, dynamic> toMap()
  {
    var map = new Map<String, dynamic>();
    map["itemName"]=_itemName;
    map["dateCreated"]=_dateCreated;

    if(_id!= null)
      {
        map["id"]=_id;
      }

    return map;


  }

  NotepadItem.fromMap(Map<String, dynamic> map)
  {
    this._itemName= map["itemName"];
    this._dateCreated=map["dateCreated"];
    this._id=map["id"];
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_itemName,
                style: new TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.9
                ),),

              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text("Created on: $_dateCreated",
                  style: new TextStyle(
                      color:  Colors.black38,
                      fontSize: 12.5,
                      fontStyle:  FontStyle.italic
                  ),),

              )


            ],
          ),



        ],
      ),
    );
  }
}
