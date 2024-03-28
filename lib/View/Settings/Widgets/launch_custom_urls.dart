
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchCustomUrls {
  static launchURL({required String url}) async {
    try {
      await launchUrlString(url);
      // mode: LaunchMode.inAppWebView,
    } catch (e) {
      if (e is PlatformException &&
          e.code == "ACTIVITY_NOT_FOUND" &&
          e.message!.contains("whatsapp://send")) {
        throw "WhatsApp Not Found";
      } else {
        throw "Could not launch :$e";
      }
    }
  }
}
