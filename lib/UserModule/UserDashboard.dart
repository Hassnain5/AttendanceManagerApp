import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/HelperClasses/SessionManager.dart';
import 'package:first_app/UserModule/MarkAttendencePage.dart';
import 'package:first_app/UserModule/RequestLeavePage.dart';
import 'package:first_app/UserModule/ViewAttendence.dart';
import 'package:first_app/custom_widgets/AttendenceCategory.dart';
import 'package:flutter/material.dart';

class UserDashBoard extends StatelessWidget {
  final String? uid ;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   UserDashBoard({super.key, required this.uid});

  Future<String> findUserName()async {

    DocumentSnapshot userDoc= await _firestore.collection("Students").doc(uid).get();
    if(userDoc.exists) {var data = userDoc.data() as Map<String, dynamic>;
   return data["Name"] ?? "Unknown User!";
      // print("Contact: ${data["ContactNumber"]}");
    }else {
      return "Not Found !";

    }
  }

  // void getUserId(){
  //   uid= SessionManager.getUserId();
  // }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Material(
          elevation: 10,
          child: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,

            bottomOpacity: 10,
            backgroundColor:Colors.white,
            title: Align(
              alignment: Alignment.centerLeft,
              child:FutureBuilder(future: findUserName(), builder: (context, snapshot){

                if(snapshot.connectionState==ConnectionState.waiting){
                  return  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Hi ",
                        style: TextStyle(color: Color(0xff8690a2), fontSize: 24),
                      ),
                      TextSpan(
                        text:  "...",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  );
                }else if(snapshot.hasError){
                 return RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Hi ",
                        style: TextStyle(color: Color(0xff8690a2), fontSize: 24),
                      ),
                      TextSpan(
                        text:  "Not Found !",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  );
                }else{
                return  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Hi ",
                        style: TextStyle(color: Color(0xff8690a2), fontSize: 24),
                      ),
                      TextSpan(
                        text:  snapshot.data!,
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  );
                }
              })


            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
              )
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MarkAttendencePage(userId: uid)),
                  );
                },
                child: AttendenceCategory(
                  imagePath: "assets/images/ic_mark_present.png",
                  title: "Mark Attendence",
                ),
              );
            } else if (index == 1) {
              return InkWell(
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RequestLeavePage(userId: uid,)),
                );
              },
            child:AttendenceCategory(
                imagePath: "assets/images/leave_icon.png",
                title: "Request Leave",
            ));
            } else {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAttendence()),
                  );
                },
                child: AttendenceCategory(
                  imagePath: "assets/images/attendencelist_icon.png",
                  title: "View Attendence",
                ),
              );
            }
          },
        ),
      ),
    );
  }

}
