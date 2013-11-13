import 'package:polymer/polymer.dart';
import 'domains.dart';

@CustomTag('character-element')
class Characterelement extends PolymerElement {
  @published Character character;
//  @published String name="lslsl";
  
  
  Characterelement.created() : super.created() {
        
  }
}