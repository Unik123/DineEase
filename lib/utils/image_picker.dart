import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static Future<File?> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return returnedImage == null ? null : File(returnedImage.path);
  }

  static Future<File?> pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return returnedImage == null ? null : File(returnedImage.path);
  }
}
