


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentFirebaseService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup(Map<String, dynamic> body, String password ) async{
    try{
      UserCredential userCredential= await _auth.createUserWithEmailAndPassword(
          email: body["Email"],
          password: password);
      print("User created: ${userCredential.user?.uid}");
      await _firestore.collection("Students").doc(userCredential.user!.uid).set(
        body
      );

    }on FirebaseAuthException catch (e){
      String message = "Signup failed";
      if (e.code== 'email-already-in-use'){
        message = "This email is already registered.";
      }
      else if (e.code == 'weak-password') {
        message = "Password is too weak.";
      }

     }

    catch (e) {
      print("Error######################## $e");

    }
  }

}