//library PayableCheck;

import 'dart:async';
//import 'domains.dart';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;


Completer completer;

class PayableCheck {

Future<String> check(String site){
  
  completer = new Completer();
    
  Future<js.Proxy> resultF = jsonp.fetch(
      
      uri: "http://gw.sinelgamysql.appspot.com/scanips?site="+site+"&callback=?"
        
  );
  
  resultF.then((js.Proxy proxy) {
    
    elaborate(proxy); 
    
  });
  
  return completer.future;
  
}

elaborate(js.Proxy proxy){
  
  if (!(proxy["provider"] == "NotMobile")) {
    
    completer.complete(proxy["provider"]);
  } else {
    completer.complete("NotMobile");
  }
  
}


}

