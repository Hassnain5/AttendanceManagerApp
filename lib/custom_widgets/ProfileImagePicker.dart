

import 'dart:io';

import 'package:first_app/Providers/ProfileImageProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileImageProvider>(context, listen: false);
    return Column(
      children: [

        Consumer<ProfileImageProvider>(
          builder: (context,provider,_) {
            ImageProvider image;
            if(kIsWeb && provider.pickedImagePath!=null){
              image= NetworkImage(provider.pickedImagePath!);
            }else if(!kIsWeb && provider.pickedImageFile!=null){
              image= FileImage(provider.pickedImageFile!);
            }else{
              image= AssetImage("assets/images/profile.png");
            }

            return CircleAvatar(
              radius: 50,
              backgroundImage: image,
            );
          },

        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {

            provider.pickImage();
          },
          child: const Text(
            "Change Profile Picture",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

}