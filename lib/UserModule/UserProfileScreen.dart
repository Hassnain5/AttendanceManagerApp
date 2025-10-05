import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/HelperClasses/SessionManager.dart';
import 'package:first_app/SelectLogInType.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/ProfileHeader.dart';
import '../custom_widgets/ProfileMenuItem.dart';
import '../custom_widgets/ProfileMenuSection.dart';
import 'EditProfileScreen.dart';

class UserProfileScreen extends StatelessWidget {
  final String? userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserProfileScreen({super.key, this.userId});

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot userDoc =
    await _firestore.collection("Students").doc(userId).get();
    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(70),

        child: Material(
          elevation: 10,
          child: AppBar(
            automaticallyImplyLeading: false,
          toolbarHeight: 70,
            title: const Text("Edit Profile"),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,

            actions: [
              Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                  child: GestureDetector(onTap: (){
                    SessionManager.clearUserId();
                    Navigator.push(context, MaterialPageRoute(builder:
                     (context) => SelectLogInType()),);


                    },

                  child: Icon(Icons.logout_rounded,color: Colors.red,)))
            ],
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("User not found"));
          }

          final userData = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60,),
                ProfileHeader(
                  name: userData["Name"] ?? "Unknown User",
                  email: userData["Email"] ?? "No email",
                  profileImage: userData["profilePic"]?? "",
                  stats: const {"Presents": 12, "Leaves": 6, "Absents": 4},
                ),

                const SizedBox(height: 20),

                /// General Section
                ProfileMenuSection(
                  title: "General",
                  items: [
                    ProfileMenuItem(icon: Icons.edit, title: "Edit Profile", onTap: (){
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => EditProfileScreen(),
          ));
          },
                    ),

                    const ProfileMenuItem(icon: Icons.language, title: "Language"),
                    const ProfileMenuItem(
                        icon: Icons.notifications, title: "Notification"),
                  ],
                ),

                /// Other Section
                const ProfileMenuSection(
                  title: "Other",
                  items: [
                    ProfileMenuItem(icon: Icons.cleaning_services, title: "Clear Cache"),
                    ProfileMenuItem(icon: Icons.help, title: "Help Center"),
                    ProfileMenuItem(icon: Icons.description, title: "Terms and Conditions"),
                    ProfileMenuItem(icon: Icons.privacy_tip, title: "Privacy Policy"),
                    ProfileMenuItem(icon: Icons.shop, title: "Review App on Store"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// ---------------- Custom Widgets ----------------




