
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/HelperClasses/SessionManager.dart';
import 'package:first_app/Services/CloudinaryService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/ProfileImageProvider.dart';
import '../custom_widgets/ProfileImagePicker.dart';
import '../custom_widgets/ProfileTextField.dart';

class EditProfileScreen extends StatelessWidget {
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController addressController = TextEditingController();

   final  _firestore= FirebaseFirestore.instance;
   String? name;
    String? email;
   String? contactNumber;
   String? imagePath;
 Future<void> getUserInfo() async{
   final  userId= await SessionManager.getUserId();
  DocumentSnapshot doc= await _firestore.collection("Students").doc(userId).get();
  if(doc.exists){
   final userData;
    userData= doc.data() as Map<String,dynamic>;

    name = userData['Name'];
   email= userData['Email'];
   contactNumber= userData['contactNumber'];

   nameController.text = name ?? '';
   emailController.text = email ?? '';
   phoneController.text = contactNumber ?? '';
  }
}



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileImageProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const ProfileImagePicker(),

            const SizedBox(height: 20),

            /// Name
            ProfileTextField(
              controller: nameController,
              hintText: "Full Name",
            ),

            const SizedBox(height: 15),

            /// Email
            ProfileTextField(
              controller: emailController,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 15),

            /// Phone number

            ProfileTextField(
                    controller: phoneController,
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                  ),



            const SizedBox(height: 15),

            /// Address
            ProfileTextField(
              controller: addressController,
              hintText: "Address",
              maxLines: 2,
            ),

            const SizedBox(height: 30),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(provider.pickedImageFile!=null){
                    imagePath= CloudinaryService().uploadImage(provider.pickedImageFile) as String?;

                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please upload a profile picture")),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile Saved")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


