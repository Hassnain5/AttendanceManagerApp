import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditStudentsAttendanceProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> students = [];
  bool hasRecord=false;
  bool isLoading=true;
  Map<String, String> attendance = {};
  DateTime selectedDate = DateTime.now();

  // Fetch students and their attendance for selected date
  Future<void> getStudentsWithAttendance(String className, DateTime date) async {
    isLoading=true;
    students.clear();
    attendance.clear();
try{
    final String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    QuerySnapshot snapshot = await _firestore
        .collection("Students")
        .where("Class", isEqualTo: className)
        .get();

    for (var doc in snapshot.docs) {
      final studentData = {
        "id": doc.id,
        "Name": doc['Name'],
      };
      students.add(studentData);

      //  check if attendance exists for that date
      final attSnap = await _firestore
          .collection("Students")
          .doc(doc.id)
          .collection("Attendence")
          .doc(formattedDate)
          .get();

      if (attSnap.exists) {
        hasRecord=true;
        attendance[doc.id] = attSnap["status"];
      } else {
        hasRecord=false;
        attendance[doc.id] =
        "NotMarked";
      }
    }

    selectedDate = date;
    notifyListeners();
  }catch(e){
  print("error : $e");

}finally{
  isLoading=false;
  notifyListeners();
}

  }

  void setDate(DateTime date) {
    selectedDate = date;
    isLoading=true;
    notifyListeners();
  }

  void markAttendance(String studentId, String status) {
    attendance[studentId] = status;
    notifyListeners();
  }
  void markAll(String status) {
    for (var student in students) {
      attendance[student["id"]] = status;
    }
    notifyListeners();
  }

  // Update Firestore
  Future<void> updateAttendance() async {
    final String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    for (var entry in attendance.entries) {
      if (entry.value == "NotMarked") continue; // don't save unmarked students

      await _firestore
          .collection("Students")
          .doc(entry.key)
          .collection("Attendence")
          .doc(formattedDate)
          .set({
        "status": entry.value,
        "markedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }
}
