library utils;
import 'dart:math';

class GetFreePhoneNumber{
  
  String askForNumber(String msisdn){
    
    return "0942416510";
  }
    
}

class RandomFromRange{
  
  int getRandNum(int tonum){
    var rng = new Random();
    
    return rng.nextInt(tonum);
    
  }
  
}