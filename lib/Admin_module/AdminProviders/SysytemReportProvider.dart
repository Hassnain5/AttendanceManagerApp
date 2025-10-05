
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Admin_module/GenerateReports.dart';
import 'package:first_app/models/AttendanceReport.dart';
import 'package:flutter/material.dart';

class SysytemReportProvider extends ChangeNotifier {

  String sysFormatedFDate = "Select From Date";
  String sysFormatedTDate = "Select To Date";
  DateTime sysFromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime sysToDate = DateTime.now();

  List<AttendanceReport> reports=[];
  bool isLoading=false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, int> summary = {"Present": 0, "Absent": 0, "Approved": 0};


  void setSysFromDate(DateTime date) {
    final formatedDate = "${date.day}-${date.month}-${date.year}";
    sysFormatedFDate= formatedDate;
    sysFromDate = date;
    notifyListeners();
  }

  void setSysToDate(DateTime date) {
    final formatedDate = "${date.day}-${date.month}-${date.year}";
    sysFormatedTDate = formatedDate;
    sysToDate = date;
    notifyListeners();
  }



  Future<void> generateSystemReport() async {
    isLoading = true;
    notifyListeners();

    final from = "${sysFromDate.year}-${sysFromDate.month.toString().padLeft(2, '0')}-${sysFromDate.day.toString().padLeft(2, '0')}";
    final to = "${sysToDate.year}-${sysToDate.month.toString().padLeft(2, '0')}-${sysToDate.day.toString().padLeft(2, '0')}";

    final fromDate = DateTime.parse(from);
    final toDate = DateTime.parse(to);

    List<AttendanceReport> temp = [];
    try {
      final studentSnapshot = await _firestore.collection("Students").get();

      for (var doc in studentSnapshot.docs) {
        final name = doc["Name"];
        final studentId = doc.id;

        int presents = 0, absents = 0, leaves = 0;

        final attSnapshot = await _firestore
            .collection("Students")
            .doc(studentId)
            .collection("Attendence")
            .get();

        for (var attDoc in attSnapshot.docs) {
          final status = attDoc["status"];
          final dateString = attDoc.id; // your docId = date
          final date = DateTime.parse(dateString);

          if (date.isAfter(fromDate.subtract(const Duration(days: 1))) &&
              date.isBefore(toDate.add(const Duration(days: 1)))) {
            if (status == "Present") presents++;
            if (status == "Absent" ) absents++;
            if (status == "Approved") leaves++;
          }
        }

        temp.add(
          AttendanceReport(
            studentName: name,
            presents: presents,
            absents: absents,
            leaves: leaves,
          ),
        );
      }

      try {
        // fetch data
        reports = temp;
      } catch (e) {
        print("Error: $e");
      } finally {
        if (hasListeners) {
          isLoading = false;
          notifyListeners();
        }
      }

    } catch (e) {
      print("Errrorrrr!!!!!!!!!!!!!!!!!!!!!!!!! $e");
    }


  }


  Future<void> generatePdf(BuildContext context) async {
    final path = await GenerateReports.generateSystemPDF(reports);
    if (path != null) {
      print("PDF saved at: $path");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$path")));
    }
  }


}