import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/UserModule/UserLogin.dart';
import 'package:flutter/material.dart';
import 'package:first_app/custom_widgets/CustomTextField.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // bool nameError =false;
  // bool emailError =false;
  // bool contactError =false;
  // bool passwordError =false;
  // bool confirmPasswordError =false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {

    Future<void> _signup() async{
      try{
        UserCredential userCredential= await _auth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
        print("User created: ${userCredential.user?.uid}");
        await _firestore.collection("Students").doc(userCredential.user!.uid).set({
        "Name" : nameController.text.trim(),
        "Email" : emailController.text.trim(),
        "ContactNumber" : contactController.text.trim(),
      });
        nameController.clear();
        emailController.clear();
        contactController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade300,
            content: Text("SignUp Sucessfull", style: TextStyle(color: Colors.white),)));

      }on FirebaseAuthException catch (e){
        String message = "Signup failed";
        if (e.code== 'email-already-in-use'){
          message = "This email is already registered.";
        }
        else if (e.code == 'weak-password') {
          message = "Password is too weak.";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red.shade300,
            content: Text("$message\n $e", style: TextStyle(color: Colors.white),)));

      }

      catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred. $e")),
        );
      }
    }


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
                  child: ElevatedButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      String email = emailController.text.trim();
                      String contactNumber = contactController.text.trim();
                      String password = passwordController.text.trim();
                      String confirmPassword = confirmPasswordController.text.trim();


                      if(name.isEmpty ||email.isEmpty ||contactNumber.isEmpty
                          ||password.isEmpty ||confirmPassword.isEmpty ){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red.shade300,
                            content: Text("Please fill all feilds !", style: TextStyle(color: Colors.white),)));

                      }else if(password!=confirmPassword){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red.shade300,
                            content: Text("Password does'nt match", style: TextStyle(color: Colors.white),)));

                      }
                      else
                        _signup();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
