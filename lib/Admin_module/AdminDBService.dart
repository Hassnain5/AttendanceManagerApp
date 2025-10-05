
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/models/StudentReportModel.dart';

class AdminDBService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<List<Map<String, dynamic>>> getStudentNames() async {
    List<Map<String,dynamic>> tempStudentsList=[];
    final snapshot = await _firestore.collection("Students").get();

    for(var student in snapshot.docs){
      final id = student.id;
      tempStudentsList.add(
          {
            "studentName" :student["Name"].toString(),
            "studentId" :id.toString()

          });
    }
    print(tempStudentsList);
    return tempStudentsList;
  }


  Future<StudentReportModel> generateUserReport(String studentId, DateTime fromDate, DateTime toDate) async {

    List<Map<String, dynamic>> tempList=[];
    int presents=0, absents=0, leaves=0;
    final snapshot = await _firestore
        .collection("Students")
        .doc(studentId)
        .collection("Attendence").get();

    for (var attDoc in snapshot.docs){
      final dateInString= attDoc.id;
      final date = DateTime.parse(dateInString);
    final String status;

      if(attDoc["status"] == "Pending"){
        status="Leave Requested";
      }else if(attDoc["status"] == "Approved"){
        status="Leave";
      }else if(attDoc["status"] == "Rejected"){
        status="Leave Rejected";
      }else {
        status = attDoc["status"];
        print(status);
      }


      if (
      date.isAfter(fromDate.subtract(Duration(days: 1)))
          &&
          date.isBefore(toDate.add(Duration(days: 1)))){
        if (attDoc["status"] == "Present") presents++;
        if (attDoc["status"] == "Absent" ) absents++;
        if (attDoc["status"] == "Approved") leaves++;
        tempList.add({
          "date" : dateInString,
          "status": status.toString()
        });
      }
    }
    print(tempList);

    print("Presents: $presents\n Absents: $absents\n Leaves: $leaves\n");
    return StudentReportModel(tempList, presents, absents, leaves);

  }
}