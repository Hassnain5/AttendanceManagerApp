
import 'package:flutter/widgets.dart';

class MapListProvider extends ChangeNotifier{
  List<Map<String,dynamic>> _listData =[];

  //Events
void addData (Map<String,dynamic> data){

  _listData.add(data);
  notifyListeners();

  }
  void updateData(Map<String,dynamic> updatedData, int index){
  _listData[index]= updatedData;
  notifyListeners();
  }
  void deleteData(int index){
  _listData.removeAt(index);
  notifyListeners();
  }

 List<Map<String, dynamic>> getData()=> _listData;
}