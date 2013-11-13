import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'events/startevent.dart' as startevent;
import 'domains.dart';
import 'characterelement.dart';

@CustomTag('left-panel')
class LeftPanel extends PolymerElement {

   List charaterarr = toObservable(new List<Character>());
  
  LeftPanel.created() : super.created() {

    Future<js.Proxy> result = jsonp.fetch(
        
        uri: "http://79.125.21.225:3090/get_characters?number=50&orient=portrait&callback=?"
          
    );
    
    result.then((js.Proxy proxy) {
      
      startevent.start();

      display(proxy,charaterarr );
      
      
    });
            
    
  }

  void display(var data,List characterarr) {
           
    for (var i=0;i < data.length;i++){
      
      var character = new Character();
      character.id = i;
      character.name = data[i].name;
      character.age = data[i].age;
      character.city = data[i].city;
      character.desc = data[i].desc;
      character.img = data[i].img.replaceFirst("thumb", "w110shadow6");
      character.moto = data[i].moto;
      character.phone = data[i].phone;

      characterarr.add(character);
      
      var rng = new Random();
      var rngint =rng.nextInt(characterarr.length);
      Characterelement characterelement = querySelector('#character-element');
      characterelement.character=charaterarr[rngint];
      
      
    }

  }
  
  void selectCharacter(Event e) {
    
    var sel = e.currentTarget as Element;
    var id =  int.parse((e.currentTarget as Element).id);
//    var old;
//    var old =querySelector('#click-counter').getAttribute("count");
//    querySelector('#click-counter').setAttribute("count","11");
//    querySelector('#character-element').setAttribute("character",charaterarr[0]);
//    querySelector('#character-element').setAttribute("name","test");
    Characterelement characterelement = querySelector('#character-element');
//    characterelement.name="test";
    characterelement.character=charaterarr[id];
    
//    old="11";
    
//    print(old);
    
    
  }
  
  
}

