


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaveRequestDatesProvider extends ChangeNotifier{

  List<DateTime> selectedDates = [];
bool isLoading = false;

void addDate(DateTime date){
   selectedDates.add(date);
   notifyListeners();
}
void removeDate(int index){
  selectedDates.removeAt(index);
  notifyListeners();
}
void clearDates(){
  selectedDates.clear();
  notifyListeners();
}
void loading(){
  if (isLoading){isLoading=false;}
  else isLoading=true;
  notifyListeners();
  }

}