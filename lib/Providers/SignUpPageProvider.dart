
import 'package:first_app/Services/FirebaseService/StudentFirebaseService.dart';
import 'package:flutter/material.dart';

import '../models/SignUpModel.dart';

class SignUpPageProvider extends ChangeNotifier{

  String? name;
  String? studentClass;
  String? email;
  String? contactNumber;
  String? password;

 SignUpModel? model;

 bool isLoading= false;

StudentFirebaseService service= StudentFirebaseService();


  Future<bool> signUp ()async{
isLoading =true;
notifyListeners();
    model=SignUpModel(
        id: "",
        name: name!,
        sClass: studentClass!,
        email: email!,
        contactNumber: contactNumber!,
        password: "");
try {
  await service.signup(model!.toMap() ,password!);
  isLoading =false;
  notifyListeners();
  return true;
}catch(e){
  print("Erorrr in provider !!!!! $e");
  return false;
}
    // await StudentFirebaseService.signup(SignUpModel.toMap()));
  }
}