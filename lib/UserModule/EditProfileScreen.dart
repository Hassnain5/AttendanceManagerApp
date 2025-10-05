
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





  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProfileImageProvider>(context, listen: false);
provider.getUserInfo();


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
              Consumer<ProfileImageProvider>(
                        builder: ( context, prov , _) {
                          nameController.text = provider.name ?? '';
                          emailController.text = provider.email ?? '';
                          phoneController.text = provider.contactNumber ?? '';
                          addressController.text=provider.address ?? '';

                          return Column(
                              children: [

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
                ]);
                        },),

              const SizedBox(height: 30),

              //Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final userId = await SessionManager.getUserId();

                    String? imageUrl;

                    if (provider.pickedImageFile != null || provider.pickedImageBytes != null) {
                      imageUrl = await CloudinaryService().uploadImage(
                        kIsWeb ? provider.pickedImageBytes : provider.pickedImageFile,
                        context,
                      );
                    }

                    if (provider.isPicked && imageUrl != null) {
                      await _firestore.collection("Students").doc(userId).update({
                        "profilePic": imageUrl,

                        "Name": nameController.text.trim().toString(),
                        "Email": emailController.text.trim().toString(),
                        "ContactNumber": phoneController.text.trim().toString(),
                        "Address": addressController.text.trim().toString(),
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Profile updated successfully")),
                      );
                      provider.getUserInfo();

                    }else if (provider.isPicked!=null && imageUrl ==null ){
                      await _firestore.collection("Students").doc(userId).update({

                        "Name": nameController.text.trim().toString(),
                        "Email": emailController.text.trim().toString(),
                        "contactNumber": phoneController.text.trim().toString(),
                        "Address": addressController.text.trim().toString(),
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Profile feilds updated successfully")),
                      );
                      provider.getUserInfo();
                    }

                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Error: User not found")),
                      );
                    }
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


