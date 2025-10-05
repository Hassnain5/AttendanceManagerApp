import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../HelperClasses/SessionManager.dart';

class ProfileImageProvider extends ChangeNotifier {
  File? pickedImageFile;      // For mobile/desktop
  Uint8List? pickedImageBytes; // For web
  String? pickedImagePath;
  bool isPicked = false;

  final  _firestore= FirebaseFirestore.instance;
  String? name;
  String? email;
  String? contactNumber;
  String? address;
   String? imagePath;

  Future<void> getUserInfo() async{
    final  userId= await SessionManager.getUserId();
    DocumentSnapshot doc= await _firestore.collection("Students").doc(userId).get();
    if(doc.exists){
      final userData;
      userData= doc.data() as Map<String,dynamic>;

      name = userData['Name'];
      email= userData['Email'];
      contactNumber= userData['ContactNumber'];
      address= userData['Address'];
      imagePath= userData['profilePic'];
   isPicked = false;

      notifyListeners();

    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        // ✅ Web: use bytes
        pickedImageBytes = await pickedFile.readAsBytes();
        pickedImagePath = pickedFile.name; // file name for upload
      } else {
        // ✅ Mobile/Desktop: use File
        pickedImageFile = File(pickedFile.path);
        pickedImagePath = pickedFile.path;
      }
   isPicked = true;

      notifyListeners();
    }
  }

  void clearImage() {
    pickedImageFile = null;
    pickedImageBytes = null;
    pickedImagePath = null;
    notifyListeners();
  }
}
