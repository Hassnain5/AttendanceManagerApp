import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:first_app/models/AttendanceReport.dart';

class GenerateReports {
  static Future<String?> generateSystemPDF(List<AttendanceReport> reports) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.TableHelper.fromTextArray(
            headers: ["Student Name", "Presents", "Absents", "Leaves"],
            data: reports.map<List<dynamic>>((report) {
              return [
                report.studentName,
                report.presents.toString(),
                report.absents.toString(),
                report.leaves.toString(),
              ];
            }).toList(),
          );
        },
      ),
    );

    if (kIsWeb) {
      final savedFile = await pdf.save();
      final blob = html.Blob([savedFile]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "system_report_${DateTime.now().millisecondsSinceEpoch}.pdf")
        ..click();

      html.Url.revokeObjectUrl(url);

      return null;
    } else {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/system_report.pdf");
      await file.writeAsBytes(await pdf.save());
      return file.path;
    }
  }

  static Future<String>  generateStudentPDF(List<Map<String , dynamic>> reports) async{
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.TableHelper.fromTextArray(
            headers: ["Date", "Attendance Status"],
            data: reports.map<List<dynamic>>((report) {
              return [
                report["date"],
                report["status"],
              ];
            }).toList(),
          );
        },
      ),
    );

    if (kIsWeb) {
      final savedFile = await pdf.save();
      final blob = html.Blob([savedFile]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "user_report_${DateTime.now().millisecondsSinceEpoch}.pdf")
        ..click();

      html.Url.revokeObjectUrl(url);

      return "";
    } else {
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/system_report.pdf");
      await file.writeAsBytes(await pdf.save());
      return file.path;
    }
  }

}
