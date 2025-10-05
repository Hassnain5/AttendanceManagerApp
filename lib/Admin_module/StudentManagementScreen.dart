import 'package:flutter/material.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() => _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  final List<Map<String, String>> students = [
    {"name": "Ali Khan", "email": "ali@example.com"},
    {"name": "Sara Ahmed", "email": "sara@example.com"},
    {"name": "John Doe", "email": "john@example.com"},
  ];

  String searchQuery = "";
  String sortBy = "Name";

  @override
  Widget build(BuildContext context) {
    final filteredStudents = students
        .where((s) =>
    s["name"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
        s["email"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList()
      ..sort((a, b) {
        if (sortBy == "Name") {
          return a["name"]!.compareTo(b["name"]!);
        } else {
          return a["email"]!.compareTo(b["email"]!);
        }
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
        centerTitle: true,
        elevation: 6,
        shadowColor: Colors.black45,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1),
            tooltip: "Add Student",
            onPressed: () {
              // TODO: open add student dialog/screen
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 🔎 Search + Sort Row
            Row(
              children: [
                // Search with elevation (FIX: use Material instead of boxShadow in InputDecoration)
                Expanded(
                  child: Material(
                    elevation: 6,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search students...",
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                      ),
                      onChanged: (value) => setState(() => searchQuery = value),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Sort dropdown inside elevated Material chip
                Material(
                  elevation: 6,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: sortBy,
                        items: const [
                          DropdownMenuItem(value: "Name", child: Text("Sort: Name")),
                          DropdownMenuItem(value: "Email", child: Text("Sort: Email")),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => sortBy = val);
                        },
                        icon: const Icon(Icons.sort),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 📋 Student List
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          student["name"]!.isNotEmpty ? student["name"]![0].toUpperCase() : "?",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        student["name"]!,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      subtitle: Text(student["email"]!),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: open edit student dialog/screen
                            },
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text("Edit"),
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Delete Student"),
                                  content: Text("Delete ${student["name"]}?"),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
                                    FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Delete")),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                setState(() {
                                  students.removeWhere((s) =>
                                  s["email"] == student["email"] && s["name"] == student["name"]);
                                });
                              }
                            },
                            icon: const Icon(Icons.delete, size: 18),
                            label: const Text("Delete"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
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

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: open add student dialog/screen
        },
        icon: const Icon(Icons.person_add),
        label: const Text("Add Student"),
        elevation: 8,
      ),
    );
  }
}
