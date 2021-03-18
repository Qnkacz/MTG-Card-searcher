import 'package:flutter/material.dart';
import 'package:mtg_card_attempt/API_Manager.dart';
import 'package:mtg_card_attempt/Card.dart';
import 'package:mtg_card_attempt/Utilities.dart';

import 'CardInfo.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  void initState() {
    super.initState();
  }

  void callback() {
    setState(() {
      Utilities.cardList = Utilities.cardList;
      Utilities.savedCardList = Utilities.savedCardList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: Utilities.cardList.length,
          itemBuilder: (context, index) {
            final item = Utilities.cardList[index];
            return CardInfoCard(item, callback);
          }),
    ));
  }
}

class SavedCardList extends StatefulWidget {
  @override
  _SavedCardListState createState() => _SavedCardListState();
}

class _SavedCardListState extends State<SavedCardList> {
  @override
  void initState() {
    super.initState();
  }

  void callback() {
    setState(() {
      Utilities.cardList = Utilities.cardList;
      Utilities.savedCardList = Utilities.savedCardList;
    });
  }

  void tabGo(MTGcard card) {
    API_Manager.getDataFromUrl(card.allPrints).then((value) => Utilities.cardList=value).then((value) => setState(() {
      DefaultTabController.of(context).animateTo(0);
    }));
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: Utilities.savedCardList.length,
          itemBuilder: (context, index) {
            final item = Utilities.savedCardList[index];
            return CardInfoSaved(item, callback, tabGo);
          }),
    ));
  }
}
