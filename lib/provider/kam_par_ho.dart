

import 'package:flutter/foundation.dart';

class KamParHo with ChangeNotifier {

  int _incerement = 20 ;
  int get incerement => _incerement ;

  double _opacity = .4 ;
  double get opacity => _opacity ;

  setIncrement(){
    _incerement ++ ;
    notifyListeners();
  }

  setOpacity(double value){
    _opacity = value ;
    notifyListeners();
  }
}