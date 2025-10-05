import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentsAttendanceProvider extends ChangeNotifier {
  final List<Map<String,dynamic>> students = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool isLoading=false;

  Map<String, String> attendance = {};
   DateTime selectedDate = DateTime.now();


  Future<void> getStudents(String className) async {
    isLoading=true;
    notifyListeners();
    students.clear();
    attendance.clear();

    QuerySnapshot data = await _firestore
        .collection("Students")
        .where("Class", isEqualTo: className )
        .get();
    for(var doc in data.docs){

      final studentsData= {
        "id": doc.id,
        "Name" : doc['Name'],
      };

      students.add(studentsData);
      attendance[doc.id]= "Present";
    }
    isLoading=false;
    notifyListeners();
  }

  void markAttendance(String studentId, String status) {
    attendance[studentId] = status;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void markAll(String status) {
    for (var student in students) {
      attendance[student["id"]] = status;
    }
    notifyListeners();
  }
  Future<void> saveAttendance() async{
    final String Date = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}"
        "-${selectedDate.day.toString().padLeft(2, '0')}";

    for(var attendanceDoc in attendance.entries){
   await _firestore.collection("Students")
       .doc(attendanceDoc.key)
       .collection("Attendence")
       .doc(Date).set(
     {
       "status" : attendanceDoc.value,
       "markedAt" : Date,
     }

   );
   print("Status ${attendanceDoc.value}");
   print("Status ${Date}");
    }
  }
}
