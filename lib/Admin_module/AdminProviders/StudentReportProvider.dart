import 'package:first_app/Admin_module/AdminDBService.dart';
import 'package:first_app/models/AttendanceReport.dart';
import 'package:first_app/models/StudentReportModel.dart';
import 'package:flutter/material.dart';

import '../GenerateReports.dart';

class StudentReportProvider extends ChangeNotifier {
  String formatedFromDate = "Select From Date";
  String formatedToDate = "Select To Date";
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();
  List<Map<String , dynamic>> reports=[];
  bool isLoading=false;


  String selectedStudentId ="";

  List<Map<String, dynamic>> studentsList = [];

  Map<String, int> summary = {"Present": 0, "Absent": 0, "Leave": 0};
  //get students


  Future<void> setStudentsNames() async {
    studentsList = await AdminDBService().getStudentNames();
    notifyListeners();
  }
  Future<void> generateReport() async {
    isLoading=true;

     final reportsResult= await AdminDBService().generateUserReport(selectedStudentId,fromDate,toDate);

     reports= reportsResult.reportList;
    summary["Present"]=reportsResult.presents;
    summary["Absent"]=reportsResult.absents;
    summary["Leave"]=reportsResult.leaves;

    isLoading=false;
    notifyListeners();
  }

  void setFromDate(DateTime date) {
    final formatedDate = "${date.day}-${date.month}-${date.year}";
    formatedFromDate= formatedDate;
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    final formatedDate = "${date.day}-${date.month}-${date.year}";
    formatedToDate = formatedDate;
    toDate = date;
    notifyListeners();
  }


  void setStudent(String studentId) {
    selectedStudentId = studentId;
    notifyListeners();
  }

  Future<void> generatePdf(BuildContext context) async {
    final path = await GenerateReports.generateStudentPDF(reports);
    if (path != null) {
      print("PDF saved at: $path");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$path")));
    }
  }
}
