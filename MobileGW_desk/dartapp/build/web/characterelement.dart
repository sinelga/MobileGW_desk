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

//@MirrorsUsed(targets: const['Characterelement'])
@MirrorsUsed(targets: const ['domains'], override: '*')
import 'dart:mirrors';

Chatelement _chatelement;
String _uuid;
MobileClient mobileClient;
DirectBillingResponseMessage directBillingResponseMessage;
ButtonElement buttonElement;
DivElement spinner;
String _provider;

@CustomTag('character-element')
class Characterelement extends PolymerElement with ChangeNotifier  {
  bool get applyAuthorStyles => true;
  @reflectable @published Character get character => __$character; Character __$character; @reflectable set character(Character value) { __$character = notifyPropertyChange(#character, __$character, value); }
  @reflectable @published String get placeholderstr => __$placeholderstr; String __$placeholderstr; @reflectable set placeholderstr(String value) { __$placeholderstr = notifyPropertyChange(#placeholderstr, __$placeholderstr, value); }
  @reflectable @published String get firstfrase => __$firstfrase; String __$firstfrase; @reflectable set firstfrase(String value) { __$firstfrase = notifyPropertyChange(#firstfrase, __$firstfrase, value); }
  @reflectable @published bool get payable => __$payable; bool __$payable; @reflectable set payable(bool value) { __$payable = notifyPropertyChange(#payable, __$payable, value); }
  @reflectable @published String get directnumber => __$directnumber; String __$directnumber; @reflectable set directnumber(String value) { __$directnumber = notifyPropertyChange(#directnumber, __$directnumber, value); }


  Characterelement.created() : super.created() {
    this.hidden = true;
    payable = false;

  }

  void cleanUp() {

    if (payable) {

      Timer.run(() {

        buttonElement = this.shadowRoot.querySelector('#makepaymentClick');
        buttonElement.style.display = "inline";
        spinner = this.shadowRoot.querySelector('#spinner');
        spinner.style.display = "none";
        directnumber = "";

      });

    }

  }


  void setProvider(String provider) {

    _provider = provider;


  }
  void setUp(String uuid, Chatelement chatelement) {

    _chatelement = chatelement;
    _uuid = uuid;

  }

  void setPayable(bool payable) {

    this.payable = payable;

    if (payable) {
      Timer.run(() {

        buttonElement = this.shadowRoot.querySelector('#makepaymentClick');
        spinner = this.shadowRoot.querySelector('#spinner');
        spinner.style.display = "none";

      });
    }

  }

  void startchat() {

    js.context.jQuery('#myModal').modal('show');

    var m_ask;
    var f_answer;

    if (firstfrase == "") {

      _chatelement.m_ask = placeholderstr;
      m_ask = placeholderstr;

    } else {

      _chatelement.m_ask = firstfrase;
      m_ask = firstfrase;

    }

    var urlstr = "http://79.125.25.179:8000/bot_answer/?uuid=" + _uuid + "&phone=" + character.phone + "&say=" + Uri.encodeComponent(m_ask) + "&callback=?";

    Future<js.Proxy> result = jsonp.fetch(uri: urlstr);

    result.then((js.Proxy proxy) {

      f_answer = proxy["answer"];
      _chatelement.f_answer = f_answer;
      _chatelement.waitAnswer();

    });

  }

  void makepaymentClick() {

    if (_provider == "MobileElisa") {

      spinner.style.display = "inline";
      buttonElement.style.display = "none";


      if (mobileClient == null) {

        Future<MobileClient> checkServ = setpayment.getMobileClient(_uuid);
        checkServ.then((results) {

          mobileClient = results;

          if (mobileClient.msisdn.length > 5 && mobileClient.uuid.length > 5) {

            Future<DirectBillingResponseMessage> paymentServ = makepayment.pay(mobileClient, 97);
            paymentServ.then((payresult) {

              directBillingResponseMessage = payresult;
              showPaymentResult();

            });
          }

        });

      } else {

        Future<DirectBillingResponseMessage> paymentServ = makepayment.pay(mobileClient, 97);
        paymentServ.then((payresult) {

          directBillingResponseMessage = payresult;
          showPaymentResult();

        });

      }
    } else if (_provider == "MobileSonera") {

      buttonElement.style.display = "none";

      directnumber = getDirectNumber(mobileClient);
      showPaymentResult();


    }
  }

  void showPaymentResult() {

    spinner.style.display = "none";
    if (directBillingResponseMessage.resultCode == 0) {

      directnumber = getDirectNumber(mobileClient);

    } else {

      directnumber = "Can't make Payment! Sorry";
    }

  }

  String getDirectNumber(MobileClient mobileClient) {

    return "0452305048";

  }

}
