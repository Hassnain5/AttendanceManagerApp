


import 'package:first_app/HelperClasses/CountHelper.dart';
import 'package:first_app/Providers/AttendanceCountProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String type;
  final Color color;

   StatCard({required this.title, required this.type, required this.color});
final count = CountHelper();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 20,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Selector<AttendanceCountProvider, int>(selector: (context,provider){
                if(type=="Students")return provider.studentsCount;
                else if(type=="Present")return provider.presentCount;
                else if(type=="Absent")return provider.absentCount;
                else return provider.leaveCount;
              }, builder: (BuildContext context, value, Widget? child) {
                if(value!=null){
                  return Text(value.toString(),style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color) );

                }else return CircularProgressIndicator(color: color, );

              },),



              const SizedBox(height: 6),
              Text(title, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
//