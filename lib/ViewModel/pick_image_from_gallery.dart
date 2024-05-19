import 'package:image_picker/image_picker.dart';

class PickImageFromGallery {
  static Future<String> pickPhotoFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return pickedImage?.path ?? '';
  }
}
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// Future<void> uploadImageToApi(String imagePath) async {
//   final url = 'https://dummyapi.com/upload'; // Replace with actual API endpoint
//   final imageBytes = await imagePath.readAsBytes();
//   final response = await http.post(
//     Uri.parse(url),
//     body: {
//       'image': imageBytes,
//     },
//   );
//   if (response.statusCode == 200) {
//     print('Image uploaded successfully');
//   } else {
//     print('Failed to upload image');
//   }
// }
