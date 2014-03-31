library makepayment;

import 'dart:async';
import '../domains.dart';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;

//@MirrorsUsed(targets: const[],override: '*')
//import 'dart:mirrors';


Completer completer;
DirectBillingResponseMessage directBillingResponseMessage;

Future<DirectBillingResponseMessage> pay(MobileClient mobileClient,int price){
  
  String pricestr = price.toString();
  completer = new Completer();
  String urlstr = "http://gw.sinelgamysql.appspot.com/makepayment?uuid="+mobileClient.uuid+"&msisdn="+mobileClient.msisdn+"&ip="+mobileClient.ip+"&price="+pricestr+"&callback=?";
  
  Future<js.Proxy> result = jsonp.fetch(
      
      uri: urlstr
      
  );
  
  result.then((js.Proxy proxy) {
    
    elaborate(proxy);
    
  });
  
 return completer.future;
  
}

elaborate(js.Proxy proxy){
  
  directBillingResponseMessage = new DirectBillingResponseMessage();  
  directBillingResponseMessage.resultCode = proxy["resultCode"];
  directBillingResponseMessage.resultDescription = proxy["resultDescription"];
  
  completer.complete(directBillingResponseMessage);
  
}