import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageFunctions {
  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    return pickedFile;
  }

  Future<Map<String, String>?> uploadImageToCloudinary(XFile imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/dlvgjcucf/image/upload'),
    )
      ..fields['upload_preset'] = 'cloudinary_image'
      ..files.add(http.MultipartFile.fromBytes('file', imageBytes,
          filename: 'upload.jpg'));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      String imageUrl = jsonResponse['secure_url'];
      String publicId = jsonResponse['public_id'];

      return {
        'url': imageUrl,
        'public_id': publicId,
      };
    } else {
      return null;
    }
  }

  Future<void> deleteImageFromCloudinary(String publicId) async {
    const cloudName = 'cloudinary_image';
    const apiKey = '337281251943633';
    const apiSecret = '_RbB0BYr8oB68H17zDN5fvOgnf0';

    const url = 'https://api.cloudinary.com/v1_1/$cloudName/image/destroy';

    final auth = base64Encode(utf8.encode('$apiKey:$apiSecret'));

    await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $auth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'public_id': publicId,
      }),
    );
  }
}
