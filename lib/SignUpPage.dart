import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Providers/SignUpPageProvider.dart';
import 'package:first_app/UserModule/UserLogin.dart';
import 'package:flutter/material.dart';
import 'package:first_app/custom_widgets/CustomTextField.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});
   TextEditingController nameController = TextEditingController();
   TextEditingController classController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SignUpPageProvider>(context, listen: false);



    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: SafeArea(
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
                const Text(
                  "Sign Up as a new student",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  lable: "Full Name",
                  hintText: "Enter your full name",
                  controller: nameController,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  lable: "Student Class",
                  hintText: "Enter your class",
                  controller: classController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  lable: "Email Address",
                  hintText: "example@space.com",
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  lable: "Contact Number",
                  hintText: "+92 300 1234567",
                  controller: contactController,
                  // keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  lable: "Password",
                  hintText: "Type Password",
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  lable: "Confirm Password",
                  hintText: "Re-enter Password",
                  isPassword: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: Consumer<SignUpPageProvider>(
                    builder: ( context, prov , _) {
                      return
                     ElevatedButton(
                      onPressed: prov.isLoading? (){}:() async {
                        String name = nameController.text.trim();
                        String email = emailController.text.trim();
                        String contactNumber = contactController.text.trim();
                        String studentClass = classController.text.trim();
                        String password = passwordController.text.trim();
                        String confirmPassword = confirmPasswordController.text.trim();


                        if(name.isEmpty ||email.isEmpty ||contactNumber.isEmpty || studentClass.isEmpty
                            ||password.isEmpty ||confirmPassword.isEmpty ){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red.shade300,
                              content: Text("Please fill all feilds !", style: TextStyle(color: Colors.white),)));

                        }else if(password!=confirmPassword){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red.shade300,
                              content: Text("Password does'nt match", style: TextStyle(color: Colors.white),)));

                        }
                        else{
                          prov.name=name;
                        prov.email=email;
                          prov.contactNumber=contactNumber;
                          prov.studentClass=studentClass;
                          prov.password=password;

                          bool success = await prov.signUp(); // <- make signUp return true/false

                          if (success) {
                            nameController.clear();
                            classController.clear();
                            emailController.clear();
                            contactController.clear();
                            passwordController.clear();
                            confirmPasswordController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.grey.shade300,
                                content: const Text("SignUp Successful", style: TextStyle(color: Colors.black)),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red.shade300,
                                content: const Text("SignUp Failed. Try again!", style: TextStyle(color: Colors.white)),
                              ),
                            );
                          }

                      }},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: prov.isLoading? Colors.grey: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                    },

                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "By confirming your Email, you agree to our ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "Terms of Services ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "and that you have read and understood our ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                      children: [
                        Text(
                           "Already have an account? ",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UserLogIn()));

                          },
                          child: Text(
                             "Sign In",
                            style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
