

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeColorProvider extends ChangeNotifier{
  var color = Colors.blue;

  void chnageColor(){
    if( color == Colors.blue){
      color= Colors.red;
    }
    else
      color=Colors.blue;
    notifyListeners();

  }
}