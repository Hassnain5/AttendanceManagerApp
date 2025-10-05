import 'dart:io';
import 'package:first_app/Providers/ProfileImageProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileImageProvider>(context, listen: false);
    return Column(
      children: [
    Consumer<ProfileImageProvider>(
    builder: (context, provider, _) {
      ImageProvider imageProvider;

      if (kIsWeb && provider.pickedImageBytes != null) {
        // ✅ On Web, show picked bytes
        imageProvider = MemoryImage(provider.pickedImageBytes!);
      } else if (!kIsWeb && provider.pickedImageFile != null) {
        // ✅ On Mobile/Desktop, show picked file
        imageProvider = FileImage(provider.pickedImageFile!);
      } else if (provider.imagePath != null && provider.imagePath!.isNotEmpty) {
        // ✅ Show image from Firebase if available
        imageProvider = NetworkImage(provider.imagePath!);
      } else {
        // ✅ Fallback placeholder
        imageProvider = const AssetImage("assets/images/profile.png");
      }

      return CircleAvatar(
        radius: 50,
        backgroundImage: imageProvider,
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
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
