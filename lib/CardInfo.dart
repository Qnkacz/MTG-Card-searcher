import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtg_card_attempt/API_Manager.dart';
import 'package:mtg_card_attempt/Card.dart';
import 'package:mtg_card_attempt/CardList.dart';

import 'SaveFiles.dart';
import 'Utilities.dart';

class CardInfoCard extends StatelessWidget {
  final MTGcard card;
  Function callback;
  CardInfoCard(this.card,this.callback);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        color: Colors.white70,
        child: Row(
          children: [
            Spacer(),
            Expanded(
                flex: 10,
                child: CircleAvatar(
                  radius: 40,
                  //avatar
                  backgroundImage: NetworkImage(card.artURL),
                )),
            Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3.0,0,3,0),
                  child: Column(
                    //text on middle
                    children: [
                      Text(
                        card.name,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        card.set_name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 10, //pricing
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,3,0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.dollarSign,
                          ),
                          Spacer(),
                          Text(card.USPrice.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.euroSign),
                          Spacer(),
                          Text(card.EURPrice.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.dollarSign,
                              color: Colors.indigo),
                          Spacer(),
                          Text(
                            card.foil_USPrice.toString(),
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.euroSign, color: Colors.indigo),
                          Spacer(),
                          Text(
                            card.foil_EURPrice.toString(),
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 10, //buy buttons
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: new BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20)
                          )
                  ),
                  child: Column(
                    children: [
                      MaterialButton(
                          child: Text(
                            'TCG',
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () => Utilities.LaunchInBrowser(card.tcg)),
                      MaterialButton(
                          child: Text(
                            'Market',
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () =>
                              Utilities.LaunchInBrowser(card.market)),
                      MaterialButton(
                          child: Text(
                            'Hoarder',
                            style: TextStyle(fontSize: 11),
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () =>
                              Utilities.LaunchInBrowser(card.hoarder)),
                    ],
                  ),
                )),
          ],
        ),
      ),
      onTap: (){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
            padding: EdgeInsets.all(8),
            color: Colors.indigoAccent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(card.artURL),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                        child: Text(card.name,style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(onPressed: (){
                      Utilities.savedCardList.add(card);
                      Utilities.cardList.remove(card);
                      String JsonCard = jsonEncode(Utilities.savedCardList);
                      print(JsonCard);
                      FileUtils.writeToFile(JsonCard);
                      callback();
                      Navigator.pop(context);
                    },
                      child: Text("Save"),),
                    MaterialButton(onPressed: (){
                      Utilities.cardList.clear();
                      callback();
                      API_Manager.getDataFromUrl(card.allPrints).then((value) => Utilities.cardList=value).then((value) => callback());
                      Navigator.pop(context);
                    }
                    ,child: Text("Show card variants")),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

class CardInfoSaved extends StatelessWidget {
  final MTGcard card;
  Function remove;
  Function tabReturn;
  CardInfoSaved(this.card,this.remove,this.tabReturn);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        color: Colors.white70,
        child: Row(
          children: [
            Spacer(),
            Expanded(
                flex: 10,
                child: CircleAvatar(
                  radius: 40,
                  //avatar
                  backgroundImage: NetworkImage(card.artURL),
                )),
            Expanded(
                flex: 20,
                child: Column(
                  //text on middle
                  children: [
                    Text(
                      card.name,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  ],
                )),
            Expanded(
                flex: 10, //pricing
                child: Column(
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.dollarSign,
                        ),
                        Spacer(),
                        Text(card.USPrice.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.euroSign),
                        Spacer(),
                        Text(card.EURPrice.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.dollarSign,
                            color: Colors.indigo),
                        Spacer(),
                        Text(
                          card.foil_USPrice.toString(),
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.euroSign, color: Colors.indigo),
                        Spacer(),
                        Text(
                          card.foil_EURPrice.toString(),
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )),
            Expanded(
                flex: 10, //buy buttons
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: new BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20)
                      )
                  ),
                  child: Column(
                    children: [
                      MaterialButton(
                          child: Text(
                            'TCG',
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () => Utilities.LaunchInBrowser(card.tcg)),
                      MaterialButton(
                          child: Text(
                            'Market',
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () =>
                              Utilities.LaunchInBrowser(card.market)),
                      MaterialButton(
                          child: Text(
                            'Hoarder',
                            style: TextStyle(fontSize: 11),
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () =>
                              Utilities.LaunchInBrowser(card.hoarder)),
                    ],
                  ),
                )),
          ],
        ),
      ),
      onTap: (){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
            padding: EdgeInsets.all(8),
            color: Colors.indigoAccent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(card.artURL),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(card.name,style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(onPressed: (){
                      Utilities.savedCardList.remove(card);
                      Utilities.cardList.remove(card);
                      String JsonCard = jsonEncode(Utilities.savedCardList);
                      print(JsonCard);
                      FileUtils.writeToFile(JsonCard);
                      remove();
                      Navigator.pop(context);
                    },
                      child: Text("Remove"),),
                    MaterialButton(onPressed: (){
                      Utilities.cardList.clear();
                      remove();
                      tabReturn(card);

                      Navigator.pop(context);
                    }
                        ,child: Text("Show card variants")),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }
}

