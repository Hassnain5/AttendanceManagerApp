

import 'package:first_app/Providers/AttendenceListProvider.dart';
import 'package:first_app/custom_widgets/AttendanceListWidget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../HelperClasses/SessionManager.dart';

class ViewAttendence extends StatefulWidget{



  @override
  State<ViewAttendence> createState() => _AttendenceScreenState(); }




class _AttendenceScreenState extends State<ViewAttendence> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // String? userId;
  //
  // Future<void> initUserId() async {
  //   print("called ");
  //
  //   userId = await SessionManager.getUserId();
  //   if(userId!=null){
  //     print(userId);
  //   }else
  //     print("user id Not found ");
  // }
  void initState()  {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
Future.microtask(()async{
    final provider = Provider.of<AttendenceListProvider>(context, listen: false);
    await provider.initUserId();
    await provider.getPresent();
    await provider.getAbsent();
    await provider.getRequestedLeaves();
    await provider.getLeave();
});

  }



  @override
  Widget build(BuildContext context) {
    print("buildcalled !!!!!!");
// Future<void> ge
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Attendence"),
        bottom: TabBar(
          controller: _tabController,
            tabs:  const[
               Tab(text: "Present",),
               Tab(text: "Absent",),
               Tab(text: "Requested",),
               Tab(text: "Leave",),
            ]),
      ),
        body:TabBarView(
            controller: _tabController,
            children: [
              Consumer<AttendenceListProvider>(
                  builder: (context, provider, _){
                    return AttendanceListWidget(list: provider.presentList,
                        emptyText: "No Present Records",
                      icon :Icon(Iconsax.verify5, color: Colors.green,), );}
              ),
              Consumer<AttendenceListProvider>(
                  builder: (context, provider, _){
                    return AttendanceListWidget(list: provider.absentList,
                        icon :Icon(Iconsax.calendar_remove5, color: Colors.red,),
                        emptyText: "No Absent Records");}
              ),
              Consumer<AttendenceListProvider>(
                  builder: (context, provider, _){
                    return AttendanceListWidget(list: provider.requestedList,
                        icon :Icon(Iconsax.timer5, color: Colors.brown.shade200,),
                        emptyText: "No Requested Records");}
              ),
              Consumer<AttendenceListProvider>(
                  builder: (context, provider, _){
                    return AttendanceListWidget(list: provider.leaveList,
                        icon :Icon(Iconsax.verify5, color: Colors.green,),
                        emptyText: "No Leave Records");}
              ),
            ])
    );
  }

}