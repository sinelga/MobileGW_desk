library Characterelement;

import 'package:polymer/polymer.dart';
import 'domains.dart';
import 'chatelement.dart';
import 'dart:async';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;

Chatelement _chatelement;
String _uuid;

@CustomTag('character-element')
class Characterelement extends PolymerElement {
  bool get applyAuthorStyles => true;
  @published Character character;
  @published String placeholderstr;
  @published String firstfrase;
  
    
  Characterelement.created() : super.created() {
    this.hidden = true;
        
  }
  void setUp(String uuid,Chatelement chatelement){
    
    _chatelement =chatelement;
    _uuid=uuid;
    
  }
  void startchat() {
    
        
    js.context.jQuery('#myModal').modal('show');
    
    var m_ask;
    var f_answer;
    
    if(firstfrase == ""){
      
     _chatelement.m_ask = placeholderstr;
     m_ask = placeholderstr;
      
    } else {
      
      _chatelement.m_ask = firstfrase;
      m_ask = firstfrase;
      
    }
    
    var urlstr = "http://79.125.25.179:8000/bot_answer/?uuid="+_uuid+"&phone="+character.phone+"&say="+Uri.encodeComponent(m_ask)+"&callback=?";

    
    Future<js.Proxy> result = jsonp.fetch(
        uri: urlstr
    );
    
    result.then((js.Proxy proxy) {

      f_answer = proxy["answer"];
      _chatelement.f_answer= f_answer;
      _chatelement.waitAnswer();
      
    });
    
       
        
  }
   
}