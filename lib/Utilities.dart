import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Card.dart';
class Utilities{
static String fuzzySearch = "https://api.scryfall.com/cards/named?fuzzy=";
static String search = "https://api.scryfall.com/cards/search?q=";
static String searchAllSufix = "+unique%3Aprints";
static String apiURL = "api.scryfall.com";
static String card_id = "https://api.scryfall.com/cards/";
static Future<void> LaunchInBrowser(String url) async {
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
static TabController tabController;


static List<MTGcard> cardList= <MTGcard>[];
static List<MTGcard> savedCardList = <MTGcard>[];
}
class CardInfo{
  static String cardName = "name";
  static String manaCost = "mana_cost";
  static var colors_arr = ["W","R","G","B","U"];
  static String rarity = "rarity";
  static String prices = "prices";
  static String images = "image_uris";
  static String artist = "artist";
  static String cardfaces = "card_faces";
  static String buy  ="purchase_uris";
  static String tcg = "tcgplayer";
  static String cardmarket = "cardmarket";
  static String cardhoarder = "cardhoarder";
  static String colors = "colors";
  static String id="id";
  static String prints = "prints_search_uri";
  static String set = "set_name";
}
