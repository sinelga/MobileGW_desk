library Chatelement;

import 'package:polymer/polymer.dart';
import 'domains.dart';
import 'dart:async';
import 'dart:math';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;

//@MirrorsUsed(targets: const[],override: '*')
//import 'dart:mirrors';

var subscription;
var stream;
String _uuid;

@CustomTag('chat-element')
class Chatelement extends PolymerElement {
  @published Character character;
  @published String f_avatarstr;
  @published String m_avatarstr;
  @published String m_ask;
  @published String f_answer;
  @published String answer;
  @published String visibilety;
  @published String inputvalue;
  @published String placeholderstr;
  @published String _payable;
      
  bool get applyAuthorStyles => true;
  
  Chatelement.created() : super.created() {
    visibilety="novisible";
    placeholderstr="";
    inputvalue="";
    _payable="NotMobile";
        
  }
  
  void setUp(String uuid){
    _uuid=uuid;
    
  }
  
  void setPayable(String payable){
    
    print("payable");
    _payable=payable;
    
  }
  
  
  void chatContinue(){
    
    if (inputvalue.length > 0) {
        
      m_ask = inputvalue;
      inputvalue="";
      placeholderstr="";
       
      var urlstr = "http://79.125.25.179:8000/bot_answer/?uuid="+_uuid+"&phone="+character.phone+"&say="+Uri.encodeComponent(m_ask)+"&callback=?";
   
      Future<js.Proxy> result = jsonp.fetch(
        uri: urlstr
      );
    
      result.then((js.Proxy proxy) {

        f_answer = proxy["answer"];
        visibilety="novisible";
        waitAnswer();
      
      });
    
    } else {
      
      placeholderstr = placeholderstr+"??";
    }
            
  }
  
  void waitAnswer(){

    stream = new Stream.periodic(const Duration(seconds: 1), (count) {
      
      return count;
    });

    subscription = stream.listen(null);
    
    subscription.onData((result) {
      
      answer = "Odotta.. "+result.toString();
      
      var rng = new Random();
      var rngint =rng.nextInt(100);
      if (result >rngint) {
        
        subscription.cancel();
        answer = f_answer;
        visibilety="visible";
        placeholderstr="";
        inputvalue="";
        
      }  
    
    });
    
  }
   
  void stopchat(){
    answer ="";
    placeholderstr="";
    inputvalue="";
    subscription.cancel();
    visibilety="novisible";
    js.context.jQuery('#myModal').modal('hide');
    
  }
    
}