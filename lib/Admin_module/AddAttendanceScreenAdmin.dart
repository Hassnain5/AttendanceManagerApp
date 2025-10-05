import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AdminProviders/AddStudentsAttendanceProvider.dart';

class AddAttendanceScreenAdmin extends StatelessWidget {
  final String studentClass;

  const AddAttendanceScreenAdmin({super.key, required this.studentClass});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddStudentsAttendanceProvider>(context, listen: false);
provider.getStudents(studentClass);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Attendance"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (val) {
              provider.markAll(val);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "Present", child: Text("Mark All Present")),
              const PopupMenuItem(value: "Absent", child: Text("Mark All Absent")),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Consumer<AddStudentsAttendanceProvider>(
            builder: (context, provider, _) => GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: provider.selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  provider.setDate(picked);
                }
              },
              child: Card(
                elevation: 6,
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading:
                  const Icon(Icons.calendar_today, color: Colors.blue),
                  title: const Text("Select Date"),
                  subtitle: Text(
                    "${provider.selectedDate.day}-${provider.selectedDate.month}-${provider.selectedDate.year}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.edit_calendar, color: Colors.blue),
                ),
              ),
            ),
          ),

          const Divider(),
          Expanded(
            child: Consumer<AddStudentsAttendanceProvider>(
              builder: (context, provider, _) => ListView.builder(
                itemCount: provider.students.length,
                itemBuilder: (context, index) {
                  final student = provider.students[index];
                  final studentId = student["id"];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ListTile(
                      title: Text(student["Name"].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: "Present",
                                groupValue: provider.attendance[studentId],
                                onChanged: (val) {
                                  provider.markAttendance(studentId, val!);
                                },
                              ),
                              const Text("P"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: "Absent",
                                groupValue: provider.attendance[studentId],
                                onChanged: (val) {
                                  provider.markAttendance(studentId, val!);
                                },
                              ),
                              const Text("A"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),


          Consumer<AddStudentsAttendanceProvider>(
            builder: (context,prov,_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: prov.isLoading? (){} :() {

                    provider.saveAttendance();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Attendance added sucessfully")));
                  },

                  child: const Text("Save Attendance", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: prov.isLoading? Colors.grey :Colors.indigo,

                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              );
            },

          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
