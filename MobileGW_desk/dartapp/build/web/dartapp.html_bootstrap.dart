library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'leftpanel.dart' as i0;
import 'chatelement.dart' as i1;
import 'characterelement.dart' as i2;
import 'dartapp.html.0.dart' as i3;
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'leftpanel.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'chatelement.dart' as smoke_2;
import 'package:observe/src/metadata.dart' as smoke_3;
import 'domains.dart' as smoke_4;
import 'characterelement.dart' as smoke_5;
abstract class _M0 {} // PolymerElement & ChangeNotifier

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #age: (o) => o.age,
        #answer: (o) => o.answer,
        #character: (o) => o.character,
        #charaterarr: (o) => o.charaterarr,
        #chatContinue: (o) => o.chatContinue,
        #city: (o) => o.city,
        #directnumber: (o) => o.directnumber,
        #f_answer: (o) => o.f_answer,
        #f_avatarstr: (o) => o.f_avatarstr,
        #firstfrase: (o) => o.firstfrase,
        #id: (o) => o.id,
        #img: (o) => o.img,
        #inputvalue: (o) => o.inputvalue,
        #m_ask: (o) => o.m_ask,
        #m_avatarstr: (o) => o.m_avatarstr,
        #makepaymentClick: (o) => o.makepaymentClick,
        #name: (o) => o.name,
        #payable: (o) => o.payable,
        #phone: (o) => o.phone,
        #placeholderstr: (o) => o.placeholderstr,
        #selectCharacter: (o) => o.selectCharacter,
        #startchat: (o) => o.startchat,
        #stopchat: (o) => o.stopchat,
        #visibilety: (o) => o.visibilety,
      },
      setters: {
        #answer: (o, v) { o.answer = v; },
        #character: (o, v) { o.character = v; },
        #directnumber: (o, v) { o.directnumber = v; },
        #f_answer: (o, v) { o.f_answer = v; },
        #f_avatarstr: (o, v) { o.f_avatarstr = v; },
        #firstfrase: (o, v) { o.firstfrase = v; },
        #inputvalue: (o, v) { o.inputvalue = v; },
        #m_ask: (o, v) { o.m_ask = v; },
        #m_avatarstr: (o, v) { o.m_avatarstr = v; },
        #payable: (o, v) { o.payable = v; },
        #placeholderstr: (o, v) { o.placeholderstr = v; },
        #visibilety: (o, v) { o.visibilety = v; },
      },
      parents: {
        smoke_5.Characterelement: _M0,
        smoke_2.Chatelement: _M0,
        smoke_0.LeftPanel: smoke_1.PolymerElement,
        _M0: smoke_1.PolymerElement,
      },
      declarations: {
        smoke_5.Characterelement: {
          #character: const Declaration(#character, smoke_4.Character, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #directnumber: const Declaration(#directnumber, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #firstfrase: const Declaration(#firstfrase, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #payable: const Declaration(#payable, bool, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #placeholderstr: const Declaration(#placeholderstr, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
        },
        smoke_2.Chatelement: {
          #answer: const Declaration(#answer, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #character: const Declaration(#character, smoke_4.Character, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #f_answer: const Declaration(#f_answer, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #f_avatarstr: const Declaration(#f_avatarstr, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #inputvalue: const Declaration(#inputvalue, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #m_ask: const Declaration(#m_ask, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #m_avatarstr: const Declaration(#m_avatarstr, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #payable: const Declaration(#payable, bool, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #placeholderstr: const Declaration(#placeholderstr, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #visibilety: const Declaration(#visibilety, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
        },
        smoke_0.LeftPanel: const {},
      },
      names: {
        #age: r'age',
        #answer: r'answer',
        #character: r'character',
        #charaterarr: r'charaterarr',
        #chatContinue: r'chatContinue',
        #city: r'city',
        #directnumber: r'directnumber',
        #f_answer: r'f_answer',
        #f_avatarstr: r'f_avatarstr',
        #firstfrase: r'firstfrase',
        #id: r'id',
        #img: r'img',
        #inputvalue: r'inputvalue',
        #m_ask: r'm_ask',
        #m_avatarstr: r'm_avatarstr',
        #makepaymentClick: r'makepaymentClick',
        #name: r'name',
        #payable: r'payable',
        #phone: r'phone',
        #placeholderstr: r'placeholderstr',
        #selectCharacter: r'selectCharacter',
        #startchat: r'startchat',
        #stopchat: r'stopchat',
        #visibilety: r'visibilety',
      }));
  configureForDeployment([
      () => Polymer.register('left-panel', i0.LeftPanel),
      () => Polymer.register('chat-element', i1.Chatelement),
      () => Polymer.register('character-element', i2.Characterelement),
    ]);
  i3.main();
}
