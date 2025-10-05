
class StudentReportModel{
  final List<Map<String,dynamic>> reportList;
  final presents;
  final absents;
  final leaves;

  StudentReportModel(
      this.reportList,
      this.presents,
      this.absents,
      this.leaves);
}