

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/HelperClasses/SessionManager.dart';
import 'package:flutter/cupertino.dart';

class AttendenceListProvider extends ChangeNotifier{
  List<Map<String,dynamic>> presentList=[];
  List<Map<String,dynamic>> absentList=[];
  List<Map<String,dynamic>> leaveList=[];
  List<Map<String,dynamic>> requestedList=[];
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? userId;

  Future<void> initUserId() async {
    userId = await SessionManager.getUserId();
    if(userId!=null){
      print(userId);
    }else
      print("user id Not found ");
  }


 Future<List<Map<String, dynamic>>> geAttendeceList (String status) async{
   QuerySnapshot snapshot = await _firestore
       .collection("Students")
       .doc(userId)
       .collection("Attendence")
       .where("status", isEqualTo: status ).get();


   return snapshot.docs.map((doc){
     final data = doc.data() as Map<String, dynamic>;
     data["date"]=doc.id;

     return data;
   }).toList();
 }

  Future<void> getPresent ()async{
    presentList= await geAttendeceList("Present");
    notifyListeners();
  }
  Future<void> getAbsent ()async{
    absentList= await geAttendeceList("Absent");
    notifyListeners();
  }
  Future<void> getLeave ()async{
    leaveList= await geAttendeceList("Leave");
    notifyListeners();
  }
  Future<void> getRequestedLeaves ()async{
    requestedList= await geAttendeceList("Pending");
    notifyListeners();
  }

}