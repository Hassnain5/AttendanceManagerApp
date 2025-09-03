


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AttendanceCountProvider extends ChangeNotifier{
int studentsCount=0;
int presentCount=0;
int absentCount=0;
int leaveCount=0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AttendanceCountProvider(){

    countStudents();
    countPresent();
    countAbsents();
    countLeaveRequests();
}
void countStudents() {
  _firestore.collection("Students").snapshots().listen((snapshot) {
    studentsCount = snapshot.docs.length;
    notifyListeners();
  });
}


  void countPresent(){
    DateTime now = DateTime.now();
    String today = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    _firestore.collection("Students").snapshots().listen((students) async{

      int count=0;
      
      for(var student in students.docs){
        DocumentSnapshot attendence= await _firestore
            .collection("Students")
            .doc(student.id)
            .collection("Attendence")
            .doc(today).get();

        if(attendence.exists && attendence["status"]=="Present"){
          count++;
        }


      }

      presentCount=count;
      notifyListeners();
    });
    
  }

  void countAbsents(){
    DateTime now = DateTime.now();
    String today = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    _firestore.collection("Students").snapshots().listen((students) async{

      int count=0;

      for(var student in students.docs){
        DocumentSnapshot attendence= await _firestore
            .collection("Students")
            .doc(student.id)
            .collection("Attendence")
            .doc(today).get();

        if(attendence.exists && attendence["status"]=="Absent"){
          count++;
        }


      }

      absentCount=count;
      notifyListeners();
    });

  }


void countLeaveRequests(){

  _firestore.collection("Students").snapshots().listen((students) async{

    int count=0;

    for(var student in students.docs){
      QuerySnapshot attendence= await _firestore
          .collection("Students")
          .doc(student.id)
          .collection("Attendence")
          .get();

      for (var attendanceDoc in attendence.docs){
      if(attendanceDoc.exists && attendanceDoc["status"]=="Pending"){
        count++;
      }}


    }

    leaveCount=count;
    notifyListeners();
  });

}

}
