library setpayment;


import 'dart:async';
import '../domains.dart';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;

Completer completer;
MobileClient mobileClient;
String uuidelab;

Future<MobileClient> getMobileClient(String uuid){
 
  uuidelab = uuid;
  
  completer = new Completer();
  
//  new Timer.periodic(new Duration(seconds:5), (timer) {
    
    Future<js.Proxy> result = jsonp.fetch(
        
        uri: "http://gw.sinelgamysql.appspot.com/setpayment?uuid="+uuid+"&resource=mobilephone&callback=?"
        
    );
    
    result.then((js.Proxy proxy) {
      
      elaborate(proxy);
      
    });
  
  return completer.future;
  
  
}

elaborate(js.Proxy proxy){
  
  mobileClient = new MobileClient();        
  mobileClient.msisdn = proxy["results"]["msisdn"];
  mobileClient.ip =  proxy["results"]["ip"];
  mobileClient.uuid = uuidelab;
  
  completer.complete(mobileClient);
  
  
}

