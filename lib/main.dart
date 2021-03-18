import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtg_card_attempt/API_Manager.dart';
import 'package:mtg_card_attempt/Card.dart';
import 'package:mtg_card_attempt/CardList.dart';
import 'package:mtg_card_attempt/SaveFiles.dart';
import 'package:mtg_card_attempt/Utilities.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(
      home: CardBody(),
    ));

class CardBody extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardBody> {

  void initState(){
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
    FileUtils.dir = directory;
    FileUtils.jsonFile = new File(FileUtils.dir.path + "/" + FileUtils.fileName);
    FileUtils.fileExists = FileUtils.jsonFile.existsSync();
    if (FileUtils.fileExists) this.setState(() => FileUtils.fileContent = FileUtils.jsonFile.readAsStringSync());

    if(FileUtils.fileExists){
      List<dynamic> ids = jsonDecode(FileUtils.fileContent);
      print("content of file");
      print(FileUtils.fileContent);
      List<String>  strings = [];
      ids.forEach((element) {strings.add(element['id'].toString());});
      print("string list length");
      print(strings.length);
      List<MTGcard> cards=[];
      strings.forEach((element) {
        API_Manager.getCardById(element).then((value) => cards.add(value)).then((value) => setState((){Utilities.savedCardList=cards;}));
      });

    }
    });
  }
  var onDismissed;
  final textController = TextEditingController();


  void noCardFoundSnackBar(){
    if(Utilities.cardList.length==0){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(':( no cards found',textAlign: TextAlign.center,),
        backgroundColor: Colors.blueGrey,
        duration: Duration(milliseconds: 500),
      )
      );
    }
  }

  void ReorderLists(){
    if(Utilities.cardList.length>1){
      if(Utilities.cardList[0].EURPrice>Utilities.cardList[1].EURPrice){
        setState(() {
          Utilities.cardList.sort((a,b)=>a.EURPrice.compareTo(b.EURPrice));
          Utilities.savedCardList.sort((a,b)=>a.EURPrice.compareTo(b.EURPrice));
        });
      }
      else{
        setState(() {
          Utilities.cardList.sort((b,a)=>a.EURPrice.compareTo(b.EURPrice));
          Utilities.savedCardList.sort((b,a)=>a.EURPrice.compareTo(b.EURPrice));
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[900],
      bottomSheet: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 80,
                  child: Container(
                    color: Colors.grey,
                    child: TextField(
                      onEditingComplete: ()=>{
                        setState(()=>{
                          Utilities.cardList.clear()
                        }),
                        FocusScope.of(context).unfocus(),
                        API_Manager.getData(textController.text).then((value) => setState(()=>Utilities.cardList=value),onError: (e){
                          noCardFoundSnackBar();
                        }).then((value) => print(Utilities.cardList.length)),
                      },
                      controller: textController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Card name goes here",
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black87,
                        fontSize: 19
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 20,
                    child: Container(
                      color: Colors.amber[800],
                      child: IconButton(onPressed: () => ReorderLists(),
                        icon: FaIcon(FontAwesomeIcons.retweet),),
                    ))
              ],
            ),
            Container(
              height: 50,
              color: Colors.indigoAccent,
              child: TabBar(
                indicatorColor: Colors.amber[800],
                tabs: [
                  Tab(icon: Icon(Icons.search_rounded,color: Colors.black87)),
                  Tab(icon: Icon(Icons.list_alt_rounded,color: Colors.black87)),
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,98),
        child: TabBarView(
          children: [
            SafeArea(
              child: CardList()
            ),
            SafeArea(
                child: SavedCardList()
            ),
          ],
        ),
      ),
    ));
  }
}











