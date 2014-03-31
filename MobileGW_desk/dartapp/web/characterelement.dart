library Characterelement;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'domains.dart';
import 'chatelement.dart';
import 'dart:async';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'setpayment/setpayment.dart' as setpayment;
import 'makepayment/makepayment.dart' as makepayment;

@MirrorsUsed(targets: const[],override: '*')
import 'dart:mirrors';

Chatelement _chatelement;
String _uuid;
MobileClient mobileClient;
DirectBillingResponseMessage directBillingResponseMessage;
ButtonElement buttonElement;
DivElement spinner;

@CustomTag('character-element')
class Characterelement extends PolymerElement {
  bool get applyAuthorStyles => true;
  @published Character character;
  @published String placeholderstr;
  @published String firstfrase;
  @published bool payable;
  @published String directnumber;
  
    
  Characterelement.created() : super.created() {
    this.hidden = true;
    payable =false;
           
  }
  
  void cleanUp(){
    
    if (payable) {
      
      Timer.run( () {
        
        buttonElement= this.shadowRoot.querySelector('#makepaymentClick');
        buttonElement.style.display="inline"; 
        spinner = this.shadowRoot.querySelector('#spinner');
        spinner.style.display="none";
        directnumber="";
        
      });
            
    }
    
  }
  
  void setUp(String uuid,Chatelement chatelement){
    
    _chatelement =chatelement;
    _uuid=uuid;
    
  }
  
 void setPayable(bool payable){
 
   this.payable=payable;
   
   if (payable) {
   Timer.run( () {
     
     buttonElement= this.shadowRoot.querySelector('#makepaymentClick');
     spinner = this.shadowRoot.querySelector('#spinner');
     spinner.style.display="none";
     
   });
   }
    
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
  
  void makepaymentClick(){

    buttonElement.style.display="none";
    spinner.style.display="inline";
    
    if (mobileClient == null){
   
      Future<MobileClient> checkServ = setpayment.getMobileClient(_uuid);
      checkServ.then((results) {
        
        mobileClient = results;
        
        if (mobileClient.msisdn.length > 5 && mobileClient.uuid.length > 5){
                           
          Future<DirectBillingResponseMessage> paymentServ = makepayment.pay(mobileClient, 97);
          paymentServ.then((payresult) {
            
            directBillingResponseMessage =payresult;
            showPaymentResult();
            
          });         
        }
               
      });
      
    } else {
      
      Future<DirectBillingResponseMessage> paymentServ = makepayment.pay(mobileClient, 97);
      paymentServ.then((payresult) {
        
        directBillingResponseMessage =payresult;
        showPaymentResult();
        
      });  
           
    }
           
  }
  
  void showPaymentResult(){
    
    spinner.style.display="none";
    if (directBillingResponseMessage.resultCode == 0) {
      
      directnumber = getDirectNumber(mobileClient);
      
    } else {
      
      directnumber = "Can't make Payment! Sorry";
    }
        
  }
  
  String getDirectNumber(MobileClient mobileClient){
       
    return "0452305048";
    
  }
    
}