import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MarkAttendencePage extends StatelessWidget {
  final String? userId;
  final bool isMarked = false;
  final today =DateTime.now();
  String get todayDate => _yyyyMmDd(today);

   MarkAttendencePage({super.key, required this.userId});
  String _yyyyMmDd(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> checkAttendence() async{
    DocumentSnapshot userDoc= await _firestore.collection("Students").doc(userId).collection("Attendence").doc(todayDate).get();
    if(userDoc.exists) {
      print("true");
      //
      // var data = userDoc.data() as Map<String, dynamic>;
      // if (userNameController.text.trim()== data["UserName"] && passwordController.text.trim() == data["Password"]){
      //   print("Logged in as Admin Sucessfuly");
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged in as Admin Sucessfuly")));
      // }

    }else
      print("false");

  }
  Future<void> _markAttendence() async{

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Mark Attendance",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        elevation: 4,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_sharp, color: Colors.blue[600], size: 13),
              Text("Back",
                  style: TextStyle(color: Colors.blue[600], fontSize: 13)),
            ],
          ),
        ),
      ),
      body:  FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("Students")
        .doc(userId)
        .collection("Attendence")
        .doc(todayDate)
        .get(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
    return Center(child: Text("Error: ${snapshot.error}"));
    }

    final exists = snapshot.data?.exists ?? false;

    return exists ? _alreadyMarkedUI() : _markNowUI(context);
    },
    ),

    );
  }

  Widget _alreadyMarkedUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.verify5, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Attendance already marked for today!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "You have successfully marked your attendance.\nSee you tomorrow ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _markNowUI(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.finger_scan5, size: 120, color: Colors.blue[700]),
            SizedBox(height: 20),
            Text(
              "Mark your attendance for today",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.blue[700],
              ),
              onPressed: () {
                _showConfirmationDialog(context);
              },
              child: Text(
                "Mark Present",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("Confirm Attendance"),
        content: Text("Do you want to mark your attendance for today?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
            ),
            onPressed: () async{
              await FirebaseFirestore.instance.collection("Students").doc(userId)
                  .collection("Attendence").doc(todayDate)
                  .set(
                  {

                    "markedAt" :FieldValue.serverTimestamp(),
                    "status" : "Present"
              }
              );
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Attendance marked successfully! "),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
