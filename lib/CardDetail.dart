import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtg_card_attempt/API_Manager.dart';
import 'package:mtg_card_attempt/Card.dart';
import 'package:mtg_card_attempt/SaveFiles.dart';
import 'package:mtg_card_attempt/Utilities.dart';
import 'package:mtg_card_attempt/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';


class CardDetail extends StatefulWidget {
  final MTGcard card;
  final List<MTGcard> list;
  CardDetail(this.card,this.list);
  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  Future<void> _launchInBrowser(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Color getBackgroundColor(MTGcard card){
    API_Manager.getCardById(card.id);
    if(card.colors.length>1){
      return Colors.pink[800];
    }
    else if(card.colors.length<=0){
      return Colors.blueGrey;
    }
    else{
      if(card.colors.first== CardInfo.colors_arr[0]){
        return Colors.white70;
      }
      if(card.colors.first== CardInfo.colors_arr[1]){
        return Colors.red[700];
      }
      if(card.colors.first== CardInfo.colors_arr[2]){
        return Colors.green[700];
      }
      if(card.colors.first== CardInfo.colors_arr[3]){
        return Colors.grey[800];
      }
      if(card.colors.first== CardInfo.colors_arr[4]){
        return Colors.blue[700];
      }
    }
    return Colors.deepPurple;
  }
  List<MTGcard> cardy=[];
  List<MTGcard> savedCardList =[];
  @override
  void initState() {
    savedCardList=widget.list;
    cardy.add(widget.card);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: cardListFromUrl(cardy[0].allPrints,savedCardList),
        ),
        onVerticalDragEnd: (details)=>{
          if(details.primaryVelocity<0){
            Navigator.pop(context)
          }
        },
        //onTap:()=> Navigator.pop(context),
      ),
    );
  }
}

class cardListFromUrl extends StatefulWidget {
  final String url;
  final List<MTGcard> savedCardList;
  cardListFromUrl(this.url,this.savedCardList);
  @override
  _cardListFromUrlState createState() => _cardListFromUrlState();
}

class _cardListFromUrlState extends State<cardListFromUrl> {
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
           cardList.removeAt(index);
         });

         break;
       case DismissDirection.startToEnd:
         setState((){
           savedCardList.add(cardList[index]);
           cardList.removeAt(index);
           String JsonCard = jsonEncode(savedCardList);
           print(JsonCard);
           FileUtils.writeToFile(JsonCard);
         });
         break;
     }
   }
   void ReorderLists(){
     if(cardList.length>1){
       if(cardList[0].EURPrice>cardList[1].EURPrice){
         setState(() {
           cardList.sort((a,b)=>a.EURPrice.compareTo(b.EURPrice));
           savedCardList.sort((a,b)=>a.EURPrice.compareTo(b.EURPrice));
         });
       }
       else{
         setState(() {
           cardList.sort((b,a)=>a.EURPrice.compareTo(b.EURPrice));
           savedCardList.sort((b,a)=>a.EURPrice.compareTo(b.EURPrice));
         });
       }
     }
   }
   GoShopping(MTGcard card,String shopName)  {
     if(shopName == CardInfo.tcg){
       Utilities.LaunchInBrowser(card.tcg);
     }
     if(shopName == CardInfo.cardmarket){
       Utilities.LaunchInBrowser(card.market);
     }
     if(shopName == CardInfo.cardhoarder){
       Utilities.LaunchInBrowser(card.hoarder);
     }
   }
  String url;
  List<MTGcard> cardList=[];
   List<MTGcard>  savedCardList;
  @override
  void initState() {
    url=widget.url;
    savedCardList=widget.savedCardList;
    //tutaj zbiera karty
    API_Manager.getDataFromUrl(url).then((value) => setState((){cardList=value;}));
    
    
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: Colors.blue[900],
            child: ListView.builder(itemBuilder: (context,index){
              final item = cardList[index];
              return Dismissible(
                  key: Key(item.name),
                  dismissThresholds: {
                    DismissDirection.startToEnd: 0.5,
                    DismissDirection.endToStart: 0.5
                  },
                  background: buildSwipeActionLeft(),
                  secondaryBackground: buildSwipeActionRight(),
                  child: GestureDetector(
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(cardList[index].artURL),
                              backgroundColor: Colors.amber,
                            ),
                          ),
                          Expanded(
                            flex: 30,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          cardList[index].name,
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          cardList[index].set_name,
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cardList[index].artist,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic
                                      ),
                                    )

                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.attach_money),
                                    Text(cardList[index].USPrice.toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.euro),
                                    Text(cardList[index].EURPrice.toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.attach_money,color: Colors.indigo,),
                                    Text(cardList[index].foil_USPrice.toString(),style: TextStyle(color: Colors.indigo),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.euro,color: Colors.indigo,),
                                    Text(cardList[index].foil_EURPrice.toString(),style: TextStyle(color: Colors.indigo),)
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 20,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(child: Text('TCG'),onPressed:()=>GoShopping(cardList[index],CardInfo.tcg)),
                                  MaterialButton(child: Text('MARKET'),onPressed:()=>GoShopping(cardList[index],CardInfo.cardmarket)),
                                  MaterialButton(child: Text('HOARDER'),onPressed:()=>GoShopping(cardList[index],CardInfo.cardhoarder))
                                ],
                              )
                          )
                        ],
                      ),
                      color: Colors.white70,
                    ),
                  ),
              );
            },
              itemCount: cardList.length,
            ),
          )
      ),
      bottomSheet: Container(
        color: Colors.indigoAccent,
        child: Row(
          children: [
            Expanded(child: MaterialButton(
              child: FaIcon(FontAwesomeIcons.retweet),
              onPressed: ()=>ReorderLists(),
            )),
          ],
        ),
      ),
    );
  }
}
