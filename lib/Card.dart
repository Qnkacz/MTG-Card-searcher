class MTGcard{
String name;
String artURL;
String artist;
String color;
double USPrice;
double EURPrice;
double foil_USPrice;
double foil_EURPrice;

String tcg;
String market;
String hoarder;

String id;
String allPrints;

String set_name;

List<dynamic> colors;

MTGcard(this.name,
    this.artURL,
    this.artist,
    this.USPrice,
    this.EURPrice,
    this.foil_USPrice,
    this.foil_EURPrice,
    this.tcg,
    this.market,
    this.hoarder,
    this.colors,
    this.id,
    this.allPrints,
    this.set_name,
    ){
  if(this.USPrice==null){
    this.USPrice=0;
  }
  if(this.EURPrice==null){
    this.EURPrice=0;
  }
  if(this.foil_EURPrice==null){
    this.foil_EURPrice=0;
  }
  if(this.foil_USPrice==null){
    this.foil_USPrice=0;
  }
}

Map toJson()=>{
  'id':id
};

}