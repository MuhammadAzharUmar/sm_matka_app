import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognizeTextFromImage {
  static Future<String> readTextFromImage({required String imagePath}) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
    String text = recognizedText.text;

    textRecognizer.close();
    // print("=================\b$text==============================");
    // Process the extracted text as required (e.g., display in a dialog).
    return text != "" ? text : "No text found";
  }

  //get id from text
  static List<String> extractTransactionID(String extractedText) {
    final RegExp regex =
        RegExp(r'[A-Z]?\d+'); // Matches an optional letter followed by digits
    final Iterable<Match> matches = regex.allMatches(extractedText);
    final List<String> extractedIDs =
        matches.map((match) => match.group(0).toString()).toList();
    // return extractedIDs.isNotEmpty ? extractedIDs.first : null;

    extractedIDs.removeWhere((element) => element.length < 6);
    return extractedIDs.isNotEmpty ? extractedIDs : [];
  }
}
