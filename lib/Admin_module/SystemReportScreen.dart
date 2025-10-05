import 'package:first_app/Admin_module/AdminProviders/SysytemReportProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SystemReportScreen extends StatelessWidget {
  const SystemReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SysytemReportProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("System Report"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                    const Text("System Report",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
            
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.date_range),
                            label: Consumer<SysytemReportProvider>(builder: ( context, provider, _) {
                              return  Text(provider.sysFormatedFDate);},
            
                            ), onPressed: () async{
            
                            final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: provider.sysFromDate,
                                firstDate:  DateTime(2020),
                                lastDate:  DateTime(2030));
                            if(pickedDate!=null){
                              provider.setSysFromDate(pickedDate);}
                          },
                          ),
                        ),
                        const SizedBox(width: 8),
                         Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.date_range),
                            label: Consumer<SysytemReportProvider>(builder: ( context, provider, _) {
                              return  Text(provider.sysFormatedTDate);},
            
                            ), onPressed: () async{
            
                            final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: provider.sysToDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030));
                            if(pickedDate!=null){
                              provider.setSysToDate(pickedDate);}
                          },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
            
                    // Generate System Report Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text("Generate System Report"),
                      onPressed: () {
                        provider.generateSystemReport();
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
            SizedBox(height: 20,),
    Consumer<SysytemReportProvider>(
    builder: (context, provider, _) {
      if (provider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (provider.reports.isEmpty) {
        return const Center(child: Text("No Report Data"));
      }
      return DataTable(columns: const[
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Presents")),
        DataColumn(label: Text("Absents")),
        DataColumn(label: Text("Leaves")),
      ], rows:
      provider.reports.map((r) {
        return DataRow(cells: [
          DataCell(Text(r.studentName)),
          DataCell(Text(r.presents.toString())),
          DataCell(Text(r.absents.toString())),
          DataCell(Text(r.leaves.toString())),
        ]);
      }).toList(),
      );
    })
      ],
        ),
      ),
    );
  }
}
