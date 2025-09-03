
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class CloudinaryService{
  static const String cloudName = "dkrecmmyw";
  static const String uploadPreset = "unsigned_profile_upload";

  Future<String?> uploadImage(File? imageFile) async {

    final url= Uri.parse("https://api.cloudinary.com/v_1/$cloudName/image/");

    final request = http.MultipartRequest("POST", url)
    ..fields['upload_preset']=uploadPreset
    ..files.add(await http.MultipartFile.fromPath('file', imageFile!.path));

    final response = await request.send();

    if (response.statusCode==200){
      final resStr = await response.stream.bytesToString();
      final jasonRes = json.decode(resStr);
      return jasonRes['secure_url'];
    }else{
      print("Upload failed with status: ${response.statusCode}");
      return null;
    }

  }
}