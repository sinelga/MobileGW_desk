import 'package:polymer/polymer.dart';
import 'domains.dart';

@CustomTag('character-element')
class Characterelement extends PolymerElement {
  @published Character character;
    
  Characterelement.created() : super.created() {
        
  }
}