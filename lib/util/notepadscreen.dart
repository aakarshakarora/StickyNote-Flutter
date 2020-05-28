import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:StickyNote/modal/notepaditem.dart';
import 'package:StickyNote/util/databaseclient.dart';

import 'dateformater.dart';

class NotepadScreen extends StatefulWidget {
  @override
  _NotepadScreenState createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen> {
  final TextEditingController _textEditingControler = new TextEditingController();
  var db = new DatabaseHelper();

  final List<NotepadItem> _itemList = <NotepadItem>[];

  @override
  void initState() {
    super.initState();

    _readNotepadList();
  }

  void _handleSubmit(String text) async {
    _textEditingControler.clear();
    //TimeStamp
    NotepadItem notepadItem = new NotepadItem(
        text, dateFormatted());
    int savedItemId = await db.saveItem(notepadItem);

    NotepadItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });
    print("Item Saved ID: $savedItemId");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Hexcolor("#ffffe8"),


      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemCount: _itemList.length,
                itemBuilder: (_, int index) {
                  return new Card(
                    color: Hexcolor("#fffc57"),
                    child: new ListTile(
                      title: _itemList[index],
                      onLongPress: () => _updateItem(_itemList[index], index),
                      trailing: new Listener(
                        key: new Key(_itemList[index].itemName),
                        child: new Icon(Icons.delete,
                          color: Colors.red,),
                        onPointerDown: (pointerEvent) =>
                            _deleteNotepad(_itemList[index].id, index),
                        //_deleteNoDo(_itemList[index].id, index),
                      ),
                    ),
                  );
                }),
          ),

          new Divider(
            height: 1.0,
          )
        ],
      ),


      floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.deepOrangeAccent,
          child: new ListTile(
            title: new Icon(Icons.add),
          ),
          onPressed: _showFormDialog),
    );
  }

  void _showFormDialog() {
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
                controller: _textEditingControler,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: "Item",
                    hintText: " Eg: Wake Up Early",
                    icon: new Icon(Icons.note_add)
                ),
              ))
        ],
      ),

      actions: <Widget>[
        new FlatButton(onPressed: () {
          _handleSubmit(_textEditingControler.text);
          _textEditingControler.clear();
          Navigator.pop(context);
        }, child: Text("Save")),

        new FlatButton(onPressed: () => Navigator.pop(context),
            child: Text("Cancel"))
      ],
    );
    showDialog(context: context,
        builder: (_) {
          return alert;
        });
  }

  _readNotepadList() async
  {
    List items = await db.getItems();
    items.forEach((item) {
      // NotepadItem notepadItem=NotepadItem.fromMap(item);
      //print("DB Items: ${notepadItem.itemName}");
      setState(() {
        _itemList.add(NotepadItem.map(item));
      });
    });
  }

  _deleteNotepad(int id, int index) async {
    debugPrint("Deleted Item!");

    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(NotepadItem item, int index) {
    var alert = new AlertDialog(
      title: new Text("Update Item"),
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
                controller: _textEditingControler,
                autofocus: true,

                decoration: new InputDecoration(
                    labelText:  "Item",
                    hintText: "Eg: Wake Up Early",
                    icon: new Icon(Icons.update)),
              ))
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () async {
              NotepadItem newItemUpdated = NotepadItem.fromMap(
                  {"itemName": _textEditingControler.text,
                    "dateCreated" : dateFormatted(),
                    "id" : item.id
                  });

              _handleSubmittedUpdate(index, item);//redrawing the screen
              await db.updateItem(newItemUpdated); //updating the item
              setState(() {
                _readNotepadList(); // redrawing the screen with all items saved in the db
              });

              Navigator.pop(context);

            },
            child: new Text("Update")),
        new FlatButton(onPressed: () => Navigator.pop(context),
            child: new Text("Cancel"))
      ],
    );
    showDialog(context:
    context ,builder: (_) {
      return alert;
    });



  }

  void _handleSubmittedUpdate(int index, NotepadItem item) {
    setState(() {
      _itemList.removeWhere((element) {
        _itemList[index].itemName == item.itemName;

      });

    });
  }
}
