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
class Chatelement extends PolymerElement with ChangeNotifier  {
  @reflectable @published Character get character => __$character; Character __$character; @reflectable set character(Character value) { __$character = notifyPropertyChange(#character, __$character, value); }
  @reflectable @published String get f_avatarstr => __$f_avatarstr; String __$f_avatarstr; @reflectable set f_avatarstr(String value) { __$f_avatarstr = notifyPropertyChange(#f_avatarstr, __$f_avatarstr, value); }
  @reflectable @published String get m_avatarstr => __$m_avatarstr; String __$m_avatarstr; @reflectable set m_avatarstr(String value) { __$m_avatarstr = notifyPropertyChange(#m_avatarstr, __$m_avatarstr, value); }
  @reflectable @published String get m_ask => __$m_ask; String __$m_ask; @reflectable set m_ask(String value) { __$m_ask = notifyPropertyChange(#m_ask, __$m_ask, value); }
  @reflectable @published String get f_answer => __$f_answer; String __$f_answer; @reflectable set f_answer(String value) { __$f_answer = notifyPropertyChange(#f_answer, __$f_answer, value); }
  @reflectable @published String get answer => __$answer; String __$answer; @reflectable set answer(String value) { __$answer = notifyPropertyChange(#answer, __$answer, value); }
  @reflectable @published String get visibilety => __$visibilety; String __$visibilety; @reflectable set visibilety(String value) { __$visibilety = notifyPropertyChange(#visibilety, __$visibilety, value); }
  @reflectable @published String get inputvalue => __$inputvalue; String __$inputvalue; @reflectable set inputvalue(String value) { __$inputvalue = notifyPropertyChange(#inputvalue, __$inputvalue, value); }
  @reflectable @published String get placeholderstr => __$placeholderstr; String __$placeholderstr; @reflectable set placeholderstr(String value) { __$placeholderstr = notifyPropertyChange(#placeholderstr, __$placeholderstr, value); }
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