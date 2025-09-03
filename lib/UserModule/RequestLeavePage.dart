import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Providers/LeaveRequestDatesProvider.dart';
import 'package:first_app/custom_widgets/DatesListWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestLeavePage extends StatelessWidget {
  final String? userId;
   RequestLeavePage({super.key, required this.userId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var  existingDates;
    List duplicateDates=[];
    List newDates=[];
    final datesProvider = Provider.of<LeaveRequestDatesProvider>(context, listen: false);

    Future<void> _pickDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      if (picked != null && !datesProvider.selectedDates.contains(picked)) {

          datesProvider.addDate(picked);

      }
    }

    Future <void> _submitLeave() async{



      for(int i=0; i<datesProvider.selectedDates.length; i++){
        final dates = datesProvider.selectedDates[i];
        final formatedDate= "${dates.day}-${dates.month}-${dates.year}";
        await FirebaseFirestore.instance.collection("Students").doc(userId).collection("Attendence")
            .doc(formatedDate).set({
          "markedAt" :formatedDate,
          "status" : "Pending"

        });
        // await FirebaseFirestore.instance.collection("LeaveRequests")
        //     .doc(userId).set({
        //   "date" :formatedDate,
        //   "status" : "Pending"
        //
        // });
      }
      datesProvider.clearDates();
      reasonController.clear();
      datesProvider.loading();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Leave request sent to Admin")),);

    }

    Future<void>  _checkExisted () async{

      datesProvider.loading( );

      final snapshot = await _firestore
          .collection("Students")
          .doc(userId)
          .collection("Attendence")
          .get();
      existingDates= snapshot.docs.map((doc)=>doc.id).toSet();

      for(final dates in datesProvider.selectedDates){
        final formatedDate= "${dates.day}-${dates.month}-${dates.year}";
        if(existingDates.contains(formatedDate)){
          duplicateDates.add(formatedDate);
        }else{
          newDates.add(formatedDate);
        }

      }
      if(duplicateDates.isEmpty){
        _submitLeave();
      }else {
        datesProvider.loading( );
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
               backgroundColor: Colors.red,
               content: Text("Date Already exists${duplicateDates.join(', ')}", style: TextStyle(color: Colors.white),)),
        );
      }

    }



    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Leave"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [ Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Leave Dates", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _pickDate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Add Date"),
              ),

               Expanded(child: DatesListWidget()),
              const SizedBox(height: 10),
              const Text("Reason", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter reason for leave",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

            ],
          ),
            Consumer<LeaveRequestDatesProvider>(builder: (context,provider,_){
              if(provider.isLoading){
                return Center(
                  child: Container(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey, // border color
                            width: 1,           // border thickness
                          )
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.blue,),
                      ),
                    ),
                  ),
                );
              }
              else return const SizedBox.shrink();
            })
          ]
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (){
    if (datesProvider.selectedDates.isNotEmpty && reasonController.text.isNotEmpty) {

      _checkExisted();
      
    }else {
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select date(s) and enter a reason")),
              );
              }
                        } ,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Request Leave", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ),

    );
  }
}
