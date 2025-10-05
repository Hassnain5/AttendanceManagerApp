import 'package:first_app/Admin_module/AdminProviders/StudentReportProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsReportScreen extends StatelessWidget {
  const StudentsReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentReportProvider>(context, listen: false);
    provider.setStudentsNames();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Reports"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Report Card
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("User Report",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    // Student Dropdown
                    Consumer<StudentReportProvider>(
                      builder: ( context, prov ,_ ) {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Select Student",
                          ),
                          items: prov.studentsList
                              .map<DropdownMenuItem<String>>((student) => DropdownMenuItem(
                            value: student["studentId"],
                            child: Text(student["studentName"]),
                          ))
                              .toList(),
                          onChanged: (val) {
                            prov.setStudent(val!);
                          },
                        );
                      },

                    ),
                    const SizedBox(height: 12),

                    // Date Range Pickers
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.date_range),
                            label: Consumer<StudentReportProvider>(builder: ( context, provider, _) {
                            return  Text(provider.formatedFromDate);},

                          ), onPressed: () async{

                            final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: provider.fromDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030));
                            if(pickedDate!=null){
                            provider.setFromDate(pickedDate);}
                          },
                        ),),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.date_range),
                            label: Consumer<StudentReportProvider>(builder: ( context, provider, _) {
                              return  Text(provider.formatedToDate);},

                            ), onPressed: () async{

                            final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: provider.toDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030));
                            if(pickedDate!=null){
                              provider.setToDate(pickedDate);}
                          },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Generate Report Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.analytics),
                      label: const Text("Generate Report"),
                      onPressed: () {
                        provider.generateReport();
                      },
                    ),
                    const SizedBox(height: 8),

                    // Export Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.download),
                      label: const Text("Export PDF"),
                      onPressed: () {

                        provider.generatePdf(context);
                      },
                    ),
                  ],

                ),
              ),
            ),

            const SizedBox(height: 20),


            /// --- Attendance Summary Section
            const Text("Attendance Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryCard("Presents", ),
                _buildSummaryCard("Absents", ),
                _buildSummaryCard("Leaves",),
              ],
            ),

            const SizedBox(height: 20),
            /// --- Chart Placeholder
            Consumer<StudentReportProvider>(
              builder: (context, prov, _) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Donut Chart
                          SizedBox(
                            height: 200,
                            width: 200, // added width
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 50,
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: prov.summary["Present"]!.toDouble(),
                                    title: prov.summary["Present"].toString(),
                                    radius: 60,
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.red,
                                    value: prov.summary["Absent"]!.toDouble(),
                                    title: prov.summary["Absent"].toString(),
                                    radius: 60,
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.orange,
                                    value: prov.summary["Leave"]!.toDouble(),
                                    title: prov.summary["Leave"].toString(),
                                    radius: 60,
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 24),

                          // Hero Legend Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                LegendItem(color: Colors.green, text: "Presents"),
                                SizedBox(height: 8),
                                LegendItem(color: Colors.red, text: "Absents"),
                                SizedBox(height: 8),
                                LegendItem(color: Colors.orange, text: "Leaves"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20,),
            Consumer<StudentReportProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.reports.isEmpty) {
                    return const Center(child: Text("No Report Data"));
                  }
                  return DataTable(columns: const[
                    DataColumn(label: Text("Date",style: TextStyle(fontWeight: FontWeight.bold),)),
                    DataColumn(label: Text("Attendance",style: TextStyle(fontWeight: FontWeight.bold))),
                  ], rows:
                  provider.reports.map((r) {
                    var color=Colors.black;
                    if(r["status"]=="Present"){
                      color=Colors.green;

                    }else if(r["status"]=="Absent"){
                      color=Colors.red;

                    }else if(r["status"]=="Leave Rejected"){
                      color=Colors.red;

                    }else if(r["status"]=="Leave"){
                      color=Colors.blue;

                    }else {
                      color=Colors.black;

                    }

                    return DataRow(cells: [
                      DataCell(Text(r["date"].toString(),style: TextStyle(color: color),)),
                      DataCell(Text(r["status"].toString(), style: TextStyle(color: color))),
                    ]);
                  }).toList(),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title,) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Consumer<StudentReportProvider>(
              builder: ( context, prov,  child) {
                String count ="0";

                if(title=="Presents"){
                   count =prov.summary["Present"].toString();

                }  if(title=="Absents"){
                  count =prov.summary["Absent"].toString();


                }  if(title=="Leaves"){
                  count =prov.summary["Leave"].toString();


                }
                return Text(count,
                    style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
              },

            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}