import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Admin_module/AdminDashboard.dart';
import 'package:first_app/custom_widgets/CustomTextField.dart';
import 'package:flutter/material.dart';

class AdminLogInPage extends StatelessWidget{
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var data;

  @override
  Widget build(BuildContext context) {
    Future<void> _adminLogin()async {
      DocumentSnapshot userDoc= await _firestore.collection("Admin").doc("admin123").get();
      if(userDoc.exists) { data = userDoc.data() as Map<String, dynamic>;
      if (userNameController.text.trim()== data["UserName"] && passwordController.text.trim() == data["Password"]){
        print("Logged in as Admin Sucessfuly");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdminDashboard()),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged in as Admin Sucessfuly")));
      }else if(userNameController.text.trim()!= data["UserName"]){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User name not found !!")));

      }else if(userNameController.text.trim()== data["UserName"] && passwordController.text.trim() != data["Password"]){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password does'nt match !!")));

      }
        // print("Contact: ${data["ContactNumber"]}");
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" Not found !!")));


      }
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Attendence App",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Log In as Admin",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 80),
              CustomTextField(lable: "User Name", hintText: "Enter User Name", controller: userNameController,),
              const SizedBox(height: 28),
              CustomTextField(lable: "Password", hintText: "Enter your password", isPassword: true, controller: passwordController),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    String uName = userNameController.text.trim();
                    String password = passwordController.text.trim();

                    if(uName.isEmpty
                        ||password.isEmpty  ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red.shade300,
                          content: Text("Please fill all feilds !", style: TextStyle(color: Colors.white),)));

                    }
                    else
                      _adminLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
