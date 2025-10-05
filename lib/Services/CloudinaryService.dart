import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class CloudinaryService {
  static const String cloudName = "dkrecmmyw";
  static const String uploadPreset = "unsigned_profile_upload";

  Future<String?> uploadImage(dynamic image, BuildContext context) async {
    try {
      final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      var request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = uploadPreset;

      if (kIsWeb) {
        // Web (Uint8List)
        if (image != null && image is Uint8List) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'file',
              image,
              filename: "upload.jpg",
            ),
          );
        }
      } else {
        // Mobile (File)
        if (image != null && image is File) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              image.path,
            ),
          );
        }
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final resStr = await response.stream.bytesToString();
        final jsonRes = json.decode(resStr);

        return jsonRes['secure_url']; // ✅ Return Cloudinary image URL
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload failed: ${response.statusCode}")),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return null;
    }
  }
}
