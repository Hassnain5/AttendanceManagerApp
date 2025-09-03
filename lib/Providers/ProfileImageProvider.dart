
 import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageProvider extends ChangeNotifier{
  File? pickedImageFile;
  String? pickedImagePath;

  Future<void> pickImage() async{

    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70

    );
    if(pickedFile!=null){

        pickedImagePath = pickedFile.path;
        pickedImageFile = File(pickedFile.path);

       notifyListeners();
    }
  }

}