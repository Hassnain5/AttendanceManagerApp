import 'package:first_app/Admin_module/AdminCustomWidgets/RequestedLeavesList.dart';
import 'package:first_app/Admin_module/AdminProviders/LeaveManagmentProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveManagementScreen extends StatefulWidget {
  const LeaveManagementScreen({super.key});

  @override
  State<LeaveManagementScreen> createState() => _LeaveManagementScreenState();
}

class _LeaveManagementScreenState extends State<LeaveManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.microtask(()async{
   final provider= Provider.of<LeaveManagmentProvider>(context,listen: false);
   provider.loadAllLeaves();

    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Management"),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Requests"),
            Tab(text: "Approved"),
            Tab(text: "Rejected"),
          ],
        ),
      ),
      body: Column(
          children: [
          // Any widget above
          Expanded(
          child: TabBarView(
      controller: _tabController,
      children: const [
        RequestedLeavesList(status: "Pending"),
        RequestedLeavesList(status: "Approved"),
        RequestedLeavesList(status: "Rejected"),
      ],
          ),
          ),
          ],
          ),

    );
  }
}
