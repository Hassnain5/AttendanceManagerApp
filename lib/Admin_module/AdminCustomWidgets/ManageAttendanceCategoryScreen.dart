
import 'package:first_app/Admin_module/AddAttendanceScreenAdmin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../DeleteAttendanceScreen.dart';
import '../EditAttendanceScreenAdmin.dart';

class ManageAttendanceCategoryScreen extends StatelessWidget {
  final String studentClass;
  const ManageAttendanceCategoryScreen({super.key, required this.studentClass});

  @override
  Widget build(BuildContext context) {
    print(studentClass);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Attendance"),
        centerTitle: true,
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.add_circle, color: Colors.green),
              title: const Text("Add Attendance",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("Mark students as Present or Absent"),
              trailing: const Icon(Iconsax.arrow_right_3),
              onTap: () {
                context.go("/addAttendanceAdmin",extra: studentClass);
              },
            ),
            const SizedBox(height: 15,),

            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text("Edit Attendance",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("Update attendance records"),
              trailing: const Icon(Iconsax.arrow_right_3),
              onTap: () {
                context.go("/editAttendanceAdmin",extra: studentClass);
              },
            ),
            const SizedBox(height: 15,),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete Attendance",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("Remove attendance entries"),
              trailing: const Icon(Iconsax.arrow_right_3),
              onTap: () {
                context.go("/deleteAttendanceAdmin",extra: studentClass);
              },
            ),
          ],
        ),
      ),
    );
  }


}
