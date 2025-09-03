

import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier{
  int _count=1;

  //get
   getCount()=> _count;

  ///events
  void incrementCount (){
    _count++;
    notifyListeners();
  }
  void decrementCount (){
    _count--;
    notifyListeners();
  }
}