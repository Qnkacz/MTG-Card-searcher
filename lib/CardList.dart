import 'package:flutter/material.dart';
import 'package:mtg_card_attempt/Card.dart';
import 'package:mtg_card_attempt/SingleCardInfo.dart';

class CardList extends StatefulWidget {
  List<MTGcard> searchList=[];
  List<MTGcard> saveList=[];
  CardList(this.searchList,this.saveList);
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {

  List<MTGcard> searchList = [];
  List<MTGcard> saveList=[];
  @override
  void initState(){
    searchList=widget.searchList;
    saveList=widget.saveList;
    super.initState();
  }
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.green,
          child: ListView.builder(itemBuilder: (context,index){
            final item = searchList[index];
            return SingleCardInfo(searchList[index],searchList,saveList);
        },
          itemCount: searchList.length,),
        )
    );
  }
}