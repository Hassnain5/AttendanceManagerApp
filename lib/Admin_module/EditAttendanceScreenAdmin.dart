import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'AdminProviders/EditStudentsAttendanceProvider.dart';

class EditAttendanceScreenAdmin extends StatelessWidget {
  final String studentClass;

  const EditAttendanceScreenAdmin({super.key, required this.studentClass});

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<EditStudentsAttendanceProvider>(context, listen: false);

    provider.getStudentsWithAttendance(studentClass, provider.selectedDate);

    return Scaffold(


      appBar: AppBar(title: const Text("Edit Attendance"),
          actions: [
          PopupMenuButton<String>(
          onSelected: (val) {
    provider.markAll(val);
    },
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: "Present", child: Text("Mark All Present")),
        const PopupMenuItem(
            value: "Absent", child: Text("Mark All Absent")),
      ],
    ),
    ],

    ),




      body: Column(
        children: [
          Consumer<EditStudentsAttendanceProvider>(
            builder: (context, provider, _) => GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: provider.selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  // await provider.setDate(picked);
                  await provider.getStudentsWithAttendance(studentClass, picked);
                }
              },
              child: Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.blue),
                  title: const Text("Select Date"),
                  subtitle: Text(
                    "${provider.selectedDate.day}-${provider.selectedDate.month}-${provider.selectedDate.year}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),

          const Divider(),



          //  Student List
          Expanded(
            child: Consumer<EditStudentsAttendanceProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    final items = provider.isLoading ? List.filled(7,
                        {'id': 'fake', 'Name': 'Student name', 'avatar': ''}

                    ) : provider.students;

                    return Skeletonizer(

                      enabled: provider.isLoading,

                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final student = items[index];
                          final studentId = student["id"];

                          return Card(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 12,
                                  vertical: 8),
                              child: ListTile(
                                title: Text(student["Name"]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<String>(
                                      value: "Present",
                                      groupValue: provider.attendance[studentId],
                                      onChanged: (val) =>
                                          provider.markAttendance(
                                              studentId, val!),
                                    ),
                                    const Text("P"),

                                    Radio<String>(
                                      value: "Absent",
                                      groupValue: provider.attendance[studentId],
                                      onChanged: (val) =>
                                          provider.markAttendance(
                                              studentId, val!),
                                    ),
                                    const Text("A"),

                                    if (provider.attendance[studentId] ==
                                        "NotMarked")
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "No attendance found",
                                          style: TextStyle(color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                  ],
                                ),
                              )

                          );
                        },
                      ),
                    );
                  } else {
                    if (provider.hasRecord) {
                      return ListView.builder(
                        itemCount: provider.students.length,
                        itemBuilder: (context, index) {
                          final student = provider.students[index];
                          final studentId = student["id"];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: ListTile(
                              title: Text(student["Name"]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: "Present",
                                    groupValue: provider.attendance[studentId],
                                    onChanged: (val) =>
                                        provider.markAttendance(studentId, val!),
                                  ),
                                  const Text("P"),
                                  Radio<String>(
                                    value: "Absent",
                                    groupValue: provider.attendance[studentId],
                                    onChanged: (val) =>
                                        provider.markAttendance(studentId, val!),
                                  ),
                                  const Text("A"),
                                  if (provider.attendance[studentId] ==
                                      "NotMarked")
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "No attendance found",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No attendance record found for this date"),
                      );
                    }
                  }
                }),
          ),

          // 🔹 Update Button
          ElevatedButton.icon(
            onPressed: () async {
              await provider.updateAttendance();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Attendance updated successfully")),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text("Update Attendance"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
