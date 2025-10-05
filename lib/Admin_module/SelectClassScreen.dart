
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class SelectClassScreen extends StatelessWidget{

 final List<Map<String,dynamic>> classesList=[
   { "className": "Class 1",  "value": "1" },
   { "className": "Class 2",  "value": "2" },
   { "className": "Class 3",  "value": "3" },
   { "className": "Class 4",  "value": "4" },
   { "className": "Class 5",  "value": "5" },
   { "className": "Class 6",  "value": "6" },
   { "className": "Class 7",  "value": "7" },
   { "className": "Class 8",  "value": "8" },
   { "className": "Class 9",  "value": "9" },
   { "className": "Class 10", "value": "10" },
   { "className": "Class 11", "value": "11" },
   { "className": "Class 12", "value": "12" }
 ];

 @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Attendance"),
        centerTitle: true,
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:ListView.builder(
            itemCount: classesList.length,
            itemBuilder: (context,index){

              return Column(
                children: [
                  Card(
                    color:Colors.white,
                    elevation: 6,
                    child: ListTile(
                      title: Text("${classesList[index]["className"]}",
                          style:const  TextStyle(fontWeight: FontWeight.w600)),
                      trailing: const Icon(Iconsax.arrow_right_3),
                      onTap: () {
                        context.go("/manageAttendanceCategory", extra: classesList[index]["value"].toString());
                      },
                    ),
                  ),
                  // const SizedBox(height: 15,),
                ]);
        }),




      ),
    );
  }
}