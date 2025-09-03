import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Admin_module/AdminLogInPage.dart';
import 'package:first_app/SignUpPage.dart';
import 'package:first_app/UserModule/BottomNavContainer.dart';
import 'package:first_app/UserModule/UserDashboard.dart';
import 'package:first_app/custom_widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:first_app/HelperClasses/SessionManager.dart';

class UserLogIn extends StatelessWidget{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
final sessionManager= SessionManager();
  @override
  Widget build(BuildContext context) {
    Future<void> _logIn() async{
      try{
        UserCredential userCredential= await _auth.signInWithEmailAndPassword(
            email: emailController.text.trim(), password: passwordController.text.trim());
        String uid =userCredential.user!.uid;
        await SessionManager.saveUserId(uid);
        
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavContainer(userId: uid,)));



      }on FirebaseAuthException catch (e) {
        String message = "Login failed";
        if (e.code == 'user-not-found') {
          message = "No user found with this email.";
        } else if (e.code == 'wrong-password') {
          message = "Wrong password.";
          print(e.code);
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:60),
              Row(
                children: [
                  // Image.asset("assets/images/warning_icon.png", height: 26, width: 26),
                  // const SizedBox(width: 8),
                  const Text(
                    "Attendence App",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "Log In as User",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 80),
             CustomTextField(lable: "User Name", hintText: "Enter User Name", controller: emailController,),
              const SizedBox(height: 28),
               CustomTextField(lable: "Password", hintText: "Enter your password", isPassword: true, controller: passwordController,),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: (){
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if(email.isEmpty
                        ||password.isEmpty  ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red.shade300,
                          content: Text("Please fill all feilds !", style: TextStyle(color: Colors.white),)));

                    }
                    else
                      _logIn();

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? ", style: TextStyle(color: Colors.grey, fontSize: 16)),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                      },
                      child: const Text("Sign Up", style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
