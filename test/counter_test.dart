


import 'package:asif/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  test('counter value should be incremented', (){
    final counter = Counter() ;

    counter.increment() ;
    expect(counter.value, 1);
  });

}