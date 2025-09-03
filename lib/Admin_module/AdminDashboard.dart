import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/custom_widgets/AttendenceCategory.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'AdminCustomWidgets/StatCard.dart';

class AdminDashboard extends StatelessWidget {
   AdminDashboard({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dashboard",
                  style: TextStyle(fontSize: 22,  fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),


              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  StatCard(title: "Total Students", type: "Students", color: Colors.blue),
                   StatCard(title: "Present Today", type: "Present", color: Colors.green),
                   StatCard(title: "Absent Today", type: "Absent", color: Colors.red),
                   StatCard(title: "Pending Leaves", type: "Leave", color: Colors.orange),
                ],
              ),

              const SizedBox(height: 30),
              const Text("Actions" , style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: const [
                  AttendenceCategory(title: "Manage Attendance", imagePath: "assets/icons/ic_manage_attendance.png",),
                  AttendenceCategory(title: "Manage Leave Requests", imagePath: "assets/icons/ic_manage_leave.png",),
                  AttendenceCategory(title: "Generate Report", imagePath: "assets/icons/ic_report.png",),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}

