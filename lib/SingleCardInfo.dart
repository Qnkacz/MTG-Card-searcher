import 'dart:convert';
import 'SaveFiles.dart';
import 'package:flutter/material.dart';
import 'package:mtg_card_attempt/Card.dart';

class SingleCardInfo extends StatefulWidget {
  final MTGcard card;
  final List<MTGcard> searchList;
  final List<MTGcard> saveList;
  SingleCardInfo(this.card,this.searchList,this.saveList);
  @override
  _SingleCardInfoState createState() => _SingleCardInfoState();
}

class _SingleCardInfoState extends State<SingleCardInfo> {
  MTGcard card;
  List<MTGcard> searchList;
  List<MTGcard> saveList;
  @override
  void initState() {
    this.card=widget.card;
    this.searchList=widget.searchList;
    this.saveList=widget.saveList;
    // TODO: implement initState
    super.initState();
  }

  Widget buildSwipeActionLeft()=>Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(5),
      color: Colors.lightGreen,
      child: Row(
        children: [
          Icon(Icons.save_alt_outlined, color: Colors.white70,size: 40,),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,0),
            child: Text('Archive',style: TextStyle(color: Colors.white70,fontSize: 20),),
          )
        ],
      ),
    ),
  );
  Widget buildSwipeActionRight()=>Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(15),
      color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,0),
            child: Text('Delete',style: TextStyle(color: Colors.white70,fontSize: 20),),
          ),
          Icon(Icons.delete, color: Colors.white70,size: 40,),

        ],
      ),
    ),
  );
  void dismissItem(BuildContext context, int index, DismissDirection direction) {

    switch(direction){
      case DismissDirection.endToStart:
        setState((){
          searchList.removeAt(index);
        });

        break;
      case DismissDirection.startToEnd:
        print("saving");
        setState((){
          saveList.add(searchList[index]);
          searchList.removeAt(index);
          String JsonCard = jsonEncode(saveList);
          print(JsonCard);
          FileUtils.writeToFile(JsonCard);
        });
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(card.name),
        dismissThresholds:
        {
          DismissDirection.endToStart:.5,
          DismissDirection.startToEnd:.5,
        },
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: GestureDetector(

        ));
  }
}
