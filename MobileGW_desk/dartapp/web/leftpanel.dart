import 'package:polymer/polymer.dart';
import 'dart:async';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'events/startevent.dart' as startevent;
import 'domains.dart';

@CustomTag('left-panel')
class LeftPanel extends PolymerElement {
  @published int count = 0;
//  List<Character> characterarr;
  
  final List fruits = toObservable(['apples', 'pears', 'bananas']);
//  @observable List<Character> charaterarr;
   List charaterarr = toObservable(new List<Character>());
  

  LeftPanel.created() : super.created() {
    
    print("Start left");
    Future<js.Proxy> result = jsonp.fetch(
        
        uri: "http://79.125.21.225:3090/get_characters?number=50&orient=portrait&callback=?"
          
    );
    
    result.then((js.Proxy proxy) {
      
//      print("Donloaded");
      startevent.start();
      
//      querySelector('#bigspinner').style.display="none";
      display(proxy,charaterarr );
      
      
    });
            
    
  }

//  void increment() {
//    count++;
//  }
  
  void display(var data,List characterarr) {
    
//    characterarr =  new List<Character>();
       
    for (var i=0;i < data.length;i++){
      
      print("lslslsl");
      var character = new Character();
      character.name = data[i].name;
      character.age = data[i].age;
      character.city = data[i].city;
      character.desc = data[i].desc;
      character.img = data[i].img.replaceFirst("thumb", "w110shadow6");
      character.moto = data[i].moto;
      character.phone = data[i].phone;

      characterarr.add(character);
      
    }

  }
  
}

