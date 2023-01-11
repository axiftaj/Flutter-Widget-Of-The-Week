

import 'package:flutter/cupertino.dart';

class CounterProvider with ChangeNotifier {

  int _counter = 0 ;
  int  get counter => _counter  ;

  double _opacity = .5 ;
  double  get opacity => _opacity  ;


  setOpacity(double value){
    _opacity = value ;
    notifyListeners() ;
  }
  setCounter(){
    _counter++ ;
    notifyListeners();
  }


}