import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteStudentsAttendanceProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> records = [];
  DateTime selectedDate = DateTime.now();

  // Get students
  Future<void> getAttendanceRecords(String className, DateTime date) async {
    records.clear();

    final String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    QuerySnapshot snapshot = await _firestore
        .collection("Students")
        .where("Class", isEqualTo: className)
        .get();

    for (var doc in snapshot.docs) {
      final studentId = doc.id;
      final studentName = doc['Name'];

      final attSnap = await _firestore
          .collection("Students")
          .doc(studentId)
          .collection("Attendence")
          .doc(formattedDate)
          .get();

      if (attSnap.exists) {
        records.add({
          "id": studentId,
          "name": studentName,
          "date": formattedDate,
          "status": attSnap["status"],
        });
      }
    }

    selectedDate = date;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
Future<void> deleteAll(DateTime date)async{
  final String formattedDate =
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  for (var student in records) {
    await _firestore
        .collection("Students")
        .doc(student["id"])
        .collection("Attendence")
        .doc(formattedDate)
        .delete();

    // remove locally too
    records.removeWhere(
            (rec) => rec["id"] == student["id"]);
  }
  notifyListeners();
}

  //  Delete specific student's attendance for selected date
  Future<void> deleteAttendance(String studentId, String date) async {
    await _firestore
        .collection("Students")
        .doc(studentId)
        .collection("Attendence")
        .doc(date)
        .delete();

    // remove locally too
    records.removeWhere(
            (rec) => rec["id"] == studentId && rec["date"] == date);

    notifyListeners();
  }
}
