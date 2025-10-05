
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LeaveManagmentProvider extends ChangeNotifier{
  List<Map<String,dynamic>> approvedList=[];
  List<Map<String,dynamic>> rejectedList=[];
  List<Map<String,dynamic>> pendingList=[];

  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<List<Map<String,dynamic>>> _getLeavesList(String status)async{

    List<Map<String, dynamic>> tempList = [];
try{
  QuerySnapshot snapshot = await _firestore .collection("Students")
      .get();
  for (var doc in snapshot.docs) {
    final data = doc.data() as Map<String, dynamic>;
    final studentId = doc.id;
    final studentName = doc['Name'];
    final profilePic = data.containsKey('profilePic') ? data['profilePic'] : "noProfilePic";
    final attSnap = await _firestore
        .collection("Students")
        .doc(studentId)
        .collection("Attendence")
        .where("status", isEqualTo: status)
        .get();
    if (attSnap.docs.isNotEmpty) {
          for (var aproved in attSnap.docs){
            tempList.add({
              "id": studentId,
              "name": studentName,
              "profilePic": profilePic,
              "date": aproved.id,
              "status" : aproved["status"]

            });
          }
        }
  }



    return tempList;
  }catch(e){
  print("Error !!: $e");
  return [];
}

  }


  Future<void> loadAllLeaves() async {
    isLoading = true;
    notifyListeners();

    approvedList = await _getLeavesList("Approved");
    rejectedList = await _getLeavesList("Rejected");
    pendingList = await _getLeavesList("Pending");

    isLoading = false;
    notifyListeners();
  }
  Future<void> updateStatus(String userId,int index , String date,String status)async{
    await _firestore
        .collection("Students")
        .doc(userId)
        .collection("Attendence")
        .doc(date)
        .update({
      "status" : status
    });
   final updated= pendingList[index];
    pendingList.removeAt(index);

    if(status=="Rejected"){
      updated["status"]="Rejected";
      rejectedList.add(updated);
    }else if(status=="Approved"){
      updated["status"]="Approved";
      approvedList.add(updated);

    }
    notifyListeners();
  }
}