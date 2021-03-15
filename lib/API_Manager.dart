import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mtg_card_attempt/Card.dart';
import 'package:mtg_card_attempt/Utilities.dart';
import 'dart:convert';

class API_Manager {
  static Future<List<MTGcard>> getData(String controller) async {
    String text = controller.replaceAll(" ", "+");
    text = Utilities.search + text;
    print(text);
    Response response = await get(Uri.parse(text));
    var json = jsonDecode(response.body);
    var cardList = json['data'] as List;
    List<MTGcard> cards = [];
    cardList.forEach((element) {
      
      double _us;
      double _eur;
      double _foil_eur;
      double _foil_is;
      //dollar
      if(element[CardInfo.prices]['usd']==null)
      {
        _us=0;
      }
      else{
        _us=double.parse(element[CardInfo.prices]['usd']);
      }
      //aur
      if(element[CardInfo.prices]['eur']==null)
      {
        _eur=0;
      }
      else{
        _eur=double.parse(element[CardInfo.prices]['eur']);
      }
      //dollar foil
      if(element[CardInfo.prices]['usd_foil']==null)
      {
        _foil_is=0;
      }

      else{
        _foil_is=double.parse(element[CardInfo.prices]['usd_foil']);
      }
      //eur foil
      if(element[CardInfo.prices]['eur_foil']==null)
      {
        _foil_eur=0;
      }
      else{
        _foil_eur=double.parse(element[CardInfo.prices]['eur_foil']);
      }

      if(element[CardInfo.images]!=null){
        var card = new MTGcard
          (
            element[CardInfo.cardName],
            element[CardInfo.images]['art_crop'],
            element[CardInfo.artist],
            _us,
            _eur,
            _foil_is,
            _foil_eur,
            element[CardInfo.buy][CardInfo.tcg],
            element[CardInfo.buy][CardInfo.cardmarket],
            element[CardInfo.buy][CardInfo.cardhoarder],
            element[CardInfo.colors],
            element[CardInfo.id],
            element[CardInfo.prints],
            element[CardInfo.set]
        );
        cards.add(card);
      }
      else{
        var card = new MTGcard
          (
            element[CardInfo.cardName],
            element[CardInfo.cardfaces][0][CardInfo.images]['art_crop'],
            element[CardInfo.artist],
            _us,
            _eur,
            _foil_is,
            _foil_eur,
            element[CardInfo.buy][CardInfo.tcg],
            element[CardInfo.buy][CardInfo.cardmarket],
            element[CardInfo.buy][CardInfo.cardhoarder],
            element[CardInfo.cardfaces][0][CardInfo.colors],
            element[CardInfo.id],
            element[CardInfo.prints],
            element[CardInfo.set]
        );

        cards.add(card);
      }
    });
    return cards;
  }
  static Future<List<MTGcard>> getDataFromUrl(String controller) async {
    Response response = await get(Uri.parse(controller));
    var json = jsonDecode(response.body);
    var cardList = json['data'] as List;
    List<MTGcard> cards = [];
    cardList.forEach((element) {
      double _us;
      double _eur;
      double _foil_eur;
      double _foil_is;
      //dollar
      if(element[CardInfo.prices]['usd']==null)
      {
        _us=0;
      }
      else{
        _us=double.parse(element[CardInfo.prices]['usd']);
      }
      //aur
      if(element[CardInfo.prices]['eur']==null)
      {
        _eur=0;
      }
      else{
        _eur=double.parse(element[CardInfo.prices]['eur']);
      }
      //dollar foil
      if(element[CardInfo.prices]['usd_foil']==null)
      {
        _foil_is=0;
      }

      else{
        _foil_is=double.parse(element[CardInfo.prices]['usd_foil']);
      }
      //eur foil
      if(element[CardInfo.prices]['eur_foil']==null)
      {
        _foil_eur=0;
      }
      else{
        _foil_eur=double.parse(element[CardInfo.prices]['eur_foil']);
      }

      if(element[CardInfo.images]!=null){
        var card = new MTGcard
          (
            element[CardInfo.cardName],
            element[CardInfo.images]['art_crop'],
            element[CardInfo.artist],
            _us,
            _eur,
            _foil_is,
            _foil_eur,
            element[CardInfo.buy][CardInfo.tcg],
            element[CardInfo.buy][CardInfo.cardmarket],
            element[CardInfo.buy][CardInfo.cardhoarder],
            element[CardInfo.colors],
            element[CardInfo.id],
            element[CardInfo.prints],
            element[CardInfo.set]
        );
        cards.add(card);
      }
      else{
        var card = new MTGcard
          (
            element[CardInfo.cardName],
            element[CardInfo.cardfaces][0][CardInfo.images]['art_crop'],
            element[CardInfo.artist],
            _us,
            _eur,
            _foil_is,
            _foil_eur,
            element[CardInfo.buy][CardInfo.tcg],
            element[CardInfo.buy][CardInfo.cardmarket],
            element[CardInfo.buy][CardInfo.cardhoarder],
            element[CardInfo.cardfaces][0][CardInfo.colors],
            element[CardInfo.id],
            element[CardInfo.prints],
            element[CardInfo.set]
        );

        cards.add(card);
      }
    });
    return cards;
  }
  static Future<MTGcard> getCardById(String id) async{
    String page = Utilities.card_id+id;
    print("page: "+page);
    Response response = await get(Uri.parse(page));
    var json = jsonDecode(response.body);
    double _us;
    double _eur;
    double _foil_eur;
    double _foil_is;
    //dollar
    if(json[CardInfo.prices]['usd']==null)
    {
      _us=0;
    }
    else{
      _us=double.parse(json[CardInfo.prices]['usd']);
    }
    //aur
    if(json[CardInfo.prices]['eur']==null)
    {
      _eur=0;
    }
    else{
      _eur=double.parse(json[CardInfo.prices]['eur']);
    }
    //dollar foil
    if(json[CardInfo.prices]['usd_foil']==null)
    {
      _foil_is=0;
    }

    else{
      _foil_is=double.parse(json[CardInfo.prices]['usd_foil']);
    }
    //eur foil
    if(json[CardInfo.prices]['eur_foil']==null)
    {
      _foil_eur=0;
    }
    else{
      _foil_eur=double.parse(json[CardInfo.prices]['eur_foil']);
    }

    if(json[CardInfo.images]!=null){
      return new MTGcard
        (
        json[CardInfo.cardName],
        json[CardInfo.images]['art_crop'],
        json[CardInfo.artist],
        _us,
        _eur,
        _foil_is,
        _foil_eur,
        json[CardInfo.buy][CardInfo.tcg],
        json[CardInfo.buy][CardInfo.cardmarket],
        json[CardInfo.buy][CardInfo.cardhoarder],
        json[CardInfo.colors],
        json[CardInfo.id],
        json[CardInfo.prints],
          json[CardInfo.set]
      );
    }
    else{
      return new MTGcard
        (
        json[CardInfo.cardName],
        json[CardInfo.cardfaces][0][CardInfo.images]['art_crop'],
        json[CardInfo.artist],
        _us,
        _eur,
        _foil_is,
        _foil_eur,
        json[CardInfo.buy][CardInfo.tcg],
        json[CardInfo.buy][CardInfo.cardmarket],
        json[CardInfo.buy][CardInfo.cardhoarder],
        json[CardInfo.colors],
        json[CardInfo.id],
          json[CardInfo.prints],
          json[CardInfo.set]
      );
    }
  }
}
