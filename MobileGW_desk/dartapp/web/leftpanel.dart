import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'events/startevent.dart' as startevent;
import 'domains.dart';
import 'characterelement.dart';
import 'chatelement.dart';
import 'utils.dart';
import 'payableCheck/payablecheck.dart' as payablecheck;
import 'package:uuid/uuid_client.dart';

int m_avatarint;
String m_avatarstr;
int f_avatarint;
String f_avatarstr;
String uuid;
String site;
Characterelement characterelement;
Chatelement chatelement;

@CustomTag('left-panel')
class LeftPanel extends PolymerElement {
  bool get applyAuthorStyles => true;
  Character characterselected;
  List charaterarr = toObservable(new List<Character>());
  

  LeftPanel.created() : super.created() {
    this.hidden = true;
    site = document.domain;
   
    Future<js.Proxy> result = jsonp.fetch(
        
        uri: "http://79.125.21.225:3090/get_characters?number=50&orient=portrait&callback=?"
          
    );
    
    result.then((js.Proxy proxy) {
      
      startevent.start();
      this.hidden = false;

      display(proxy,charaterarr );
            
    });
                
  }

  void display(var data,List characterarr) {
    
    m_avatarint = new RandomFromRange().getRandNum(35);
    m_avatarstr = "http://pyserv2.appspot.com/avatarsmans/avatar" + m_avatarint.toString() + ".jpg";
    f_avatarint = new RandomFromRange().getRandNum(25);
    f_avatarstr = "http://pyserv2.appspot.com/avatarsgirls/avatar" + f_avatarint.toString() + ".jpg";
    
    Uuid uuidobj = new Uuid();
    uuid = uuidobj.v1();
    
    characterelement = querySelector('#character-element');
    chatelement = querySelector('#chat-element');
    
    Future<String> ipCheckServ = new payablecheck.PayableCheck().check(site);
    ipCheckServ.then((results) {
      
      if (results == "ElisaMobile"){
        
       characterelement.setPayable(true);
       
       document.body.nodes.add(new ScriptElement()..src =
           "http://sinelga.mbgw.elisa.fi/serviceurl?id="+uuid+"&site="+site+"&resource=mobilephone&themes=adult");
        
      } else if (results == "MobileSonera"){
        
        Future<js.Proxy> result = jsonp.fetch(
            uri: "http://ippayment.info/sonera?id="+uuid+"&site="+site+"&resource=mobiledesk&themes=adult&callback=?"
            );
        result.then((js.Proxy proxy) {

//          print(proxy["msisdn"]);
//           this.hidden = false;      
//          display(proxy);
          
        });
      }
      
      
    });
        
           
    for (var i=0;i < data.length;i++){
      
      var character = new Character();
      character.id = i;
      character.name = data[i].name;
      character.age = data[i].age;
      character.city = data[i].city;
      character.desc = data[i].desc;
//      character.img = data[i].img.replaceFirst("thumb", "w110shadow6");
      character.img = data[i].img.replaceFirst("thumb", "w110shadow6_bff0000");
      character.moto = data[i].moto;
      character.phone = data[i].phone;

      characterarr.add(character);
                
    }
    
    var rng = new Random();
    var rngint =rng.nextInt(characterarr.length);
    
    var firstcharacter = new Character();
    firstcharacter.id = charaterarr[rngint].id;
    firstcharacter.name = charaterarr[rngint].name;
    firstcharacter.age = charaterarr[rngint].age;
    firstcharacter.city = charaterarr[rngint].city;
    firstcharacter.desc = charaterarr[rngint].desc;
//    firstcharacter.img = charaterarr[rngint].img.replaceFirst("w110shadow6", "w300shadow");
    firstcharacter.img = charaterarr[rngint].img.replaceFirst("w110shadow6_bff0000", "w300shadow");
    firstcharacter.moto = charaterarr[rngint].moto;
    firstcharacter.phone = charaterarr[rngint].phone;

    characterelement.character=firstcharacter;
    characterelement.placeholderstr ="Hei "+firstcharacter.name+"!";
    characterelement.firstfrase ="";
    
    chatelement.m_avatarstr = m_avatarstr;
    chatelement.f_avatarstr = f_avatarstr;
    chatelement.setUp(uuid);
    
    chatelement.character=firstcharacter;
    
    characterelement.hidden=false;
    characterelement.setUp(uuid,chatelement);
        
        
  }
  
  void selectCharacter(Event e) {

    var id =  int.parse((e.currentTarget as Element).id);

    characterelement.placeholderstr ="Hei "+charaterarr[id].name+"!";
    characterelement.firstfrase ="";
    
    chatelement.m_avatarstr = m_avatarstr;
    f_avatarint = new RandomFromRange().getRandNum(25);
    f_avatarstr = "http://pyserv2.appspot.com/avatarsgirls/avatar" + f_avatarint.toString() + ".jpg";
    
    chatelement.f_avatarstr = f_avatarstr;
    characterelement.setUp(uuid,chatelement);
    characterselected = charaterarr[id];
    
    characterselected.img=characterselected.img.replaceFirst("w110shadow6_bff0000", "w300shadow");
    characterelement.cleanUp();
    characterelement.character=characterselected;
    chatelement.character=charaterarr[id];
            
  }
    
}

