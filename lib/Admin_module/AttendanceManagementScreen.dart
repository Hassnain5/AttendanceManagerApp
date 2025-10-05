

import 'package:flutter/material.dart';

class AttendanceManagementScreen extends StatefulWidget {
  const AttendanceManagementScreen({super.key});

  @override
  State<AttendanceManagementScreen> createState() =>
      _AttendanceManagementScreenState();
}

class _AttendanceManagementScreenState
    extends State<AttendanceManagementScreen> {
  final List<Map<String, dynamic>> attendanceRecords = [
    {"name": "Ali Khan", "date": "2025-09-01", "status": "Present"},
    {"name": "Sara Ahmed", "date": "2025-09-01", "status": "Absent"},
    {"name": "John Doe", "date": "2025-09-01", "status": "Present"},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredRecords = attendanceRecords
        .where((r) =>
    r["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        r["date"].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Management"),
        centerTitle: true,
        elevation: 6,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 🔍 Search bar with elevation
            Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search by name or date...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),

            // 📋 Attendance list
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  final record = filteredRecords[index];
                  return Card(
                    elevation: 5,
                    margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: record["status"] == "Present"
                            ? Colors.green
                            : Colors.red,
                        child: Icon(
                          record["status"] == "Present"
                              ? Icons.check
                              : Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(record["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text("Date: ${record["date"]}"),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          // 🖊 Edit
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _editAttendanceDialog(context, record, index);
                            },
                          ),
                          // 🗑 Delete
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                attendanceRecords.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ➕ Add Attendance FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addAttendanceDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Attendance"),
        elevation: 8,
      ),
    );
  }

  // 📌 Add Attendance Dialog
  void _addAttendanceDialog(BuildContext context) {
    String name = "";
    String status = "Present";
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Add Attendance"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Student Name"),
                onChanged: (value) => name = value,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: status,
                items: const [
                  DropdownMenuItem(value: "Present", child: Text("Present")),
                  DropdownMenuItem(value: "Absent", child: Text("Absent")),
                ],
                onChanged: (val) => status = val!,
                decoration: const InputDecoration(labelText: "Status"),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Date: "),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    child: Text(
                        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  attendanceRecords.add({
                    "name": name,
                    "date":
                    "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                    "status": status
                  });
                });
                Navigator.pop(ctx);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // 📌 Edit Attendance Dialog
  void _editAttendanceDialog(
      BuildContext context, Map<String, dynamic> record, int index) {
    String name = record["name"];
    String status = record["status"];
    DateTime selectedDate = DateTime.parse(record["date"]);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Edit Attendance"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: name),
                decoration: const InputDecoration(labelText: "Student Name"),
                onChanged: (value) => name = value,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: status,
                items: const [
                  DropdownMenuItem(value: "Present", child: Text("Present")),
                  DropdownMenuItem(value: "Absent", child: Text("Absent")),
                ],
                onChanged: (val) => status = val!,
                decoration: const InputDecoration(labelText: "Status"),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Date: "),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    child: Text(
                        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  attendanceRecords[index] = {
                    "name": name,
                    "date":
                    "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                    "status": status
                  };
                });
                Navigator.pop(ctx);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
