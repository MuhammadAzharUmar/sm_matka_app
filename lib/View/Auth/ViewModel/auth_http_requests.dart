import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/View/Auth/Screens/change_password.dart';
import 'package:sm_matka/View/Auth/Screens/login.dart';
import 'package:sm_matka/View/Auth/Screens/login_pin.dart';
import 'package:sm_matka/View/Auth/Screens/otp_verification.dart';
import 'package:sm_matka/View/Home/Screens/home.dart';
import 'package:sm_matka/View/Home/Screens/main_screen.dart';

class AuthHttpRequests {

  static String baseUrl = "https://smweb.demo-snp.com/api/Api";
  static signupRequest(
      {required String name,
      required String mobile,
      required String password,
      required String pin,
      required BuildContext context}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/signup'));
      request.fields.addAll({
        'full_name': name,
        'mobile': mobile,
        'pin': pin,
        'password': password
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          // SnackBarMessage.simpleSnackBar(
          //   text: jsonData["message"],
          //   // ignore: use_build_context_synchronously
          //   context: context,
          // );

          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                forgotPasswordcaller: "signup",
                phoneNumber: mobile,
              ),
            ),
          );
          // ignore: use_build_context_synchronously
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static resendOtpRequest({
    required String mobile,
    required BuildContext context,
  }) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/resend_otp'));
      request.fields.addAll({'mobile': mobile});

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.simpleSnackBar(
            text: jsonData["message"],

            // ignore: use_build_context_synchronously
            context: context,
          );
          // ignore: use_build_context_synchronously
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
      if (kDebugMode) {
        print("error $e");
      }
    }
  }

  static verifyOtpRequest(
      {required String mobile,
      required String otp,
      required BuildContext context}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/verify_otp'));
      request.fields.addAll({'mobile': mobile, 'otp': otp});
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          // SnackBarMessage.simpleSnackBar(
          //   text: jsonData["message"],
          //   // ignore: use_build_context_synchronously
          //   context: context,
          // );
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static verifyUserRequest(
      {required String mobile,
      required String otp,
      required String caller,
      required BuildContext context,
      }) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/verify_user'));
      request.fields.addAll({'mobile': mobile, 'otp': otp});
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          // SnackBarMessage.simpleSnackBar(
          //   text: jsonData["message"],
          //   // ignore: use_build_context_synchronously
          //   context: context,
          // );
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChangePasswordPage(
                token: jsonData["data"]["token"],
                mobile: mobile,
                caller: caller,
              ),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
          // just for testing purpose
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) =>  ChangePasswordPage(token: "",mobile: "123",caller: caller,),
          //   ),
          // );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static loginRequest(
      {required String mobile,
      required String password,
      required BuildContext context}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/login'));
      request.fields.addAll({'mobile': mobile, 'password': password});
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          // SnackBarMessage.simpleSnackBar(
          //   text: jsonData["message"],
          //   // ignore: use_build_context_synchronously
          //   context: context,
          // );
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginPin(
                token: jsonData["data"]["token"],
              ),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static loginPinRequest(
      {required String token,
      required String pin,
      required BuildContext context}) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/login_pin'));
      request.fields.addAll({'pin': pin});
      //add header
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.simpleSnackBar(
            text: jsonData["message"],
            // ignore: use_build_context_synchronously
            context: context,
          );
          String token =jsonData["data"]["token"];
          if (token!=""&&token.isNotEmpty) {
            
          preferences.setString("userToken", jsonData["data"]["token"]);
          // ignore: use_build_context_synchronously
          Navigator.of(context).popUntil(
            (route) => route.isFirst,
          );
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const  MainPage(currentIndex: 0,),
            ),
          );
          } 
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static forgotPasswordRequest(
      {required String mobile, required BuildContext context}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/forgot_password'));
      request.fields.addAll({'mobile': mobile});

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.simpleSnackBar(
            text: jsonData["message"],
            // ignore: use_build_context_synchronously
            context: context,
          );

          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                forgotPasswordcaller: "password",
                phoneNumber: mobile,
              ),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static forgotPinRequest(
      {required String mobile, required BuildContext context}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/forgot_pin'));
      request.fields.addAll({'mobile': mobile});
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.simpleSnackBar(
            text: jsonData["message"],
            // ignore: use_build_context_synchronously
            context: context,
          );

          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                forgotPasswordcaller: "pin",
                phoneNumber: mobile,
              ),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static createPinRequest(
      {required String mobile,
      required String token,
      required String pin,
      required BuildContext context}) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/create_pin'));
      request.fields.addAll({'mobile': mobile, 'pin': pin});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.simpleSnackBar(
            text: jsonData["message"],
            // ignore: use_build_context_synchronously
            context: context,
          );

          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }

  static forgotPasswordVerifyRequest(
      {required String mobile,
      required String token,
      required String password,
      required BuildContext context}) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/forgot_password_verify'));
      request.fields.addAll({'mobile': mobile, 'password': password});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.simpleSnackBar(
            text: jsonData["message"],
            // ignore: use_build_context_synchronously
            context: context,
          );

          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            // ignore: use_build_context_synchronously
            context: context,
          );
        }
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          // ignore: use_build_context_synchronously
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        // ignore: use_build_context_synchronously
        text: "Error!", context: context,
      );
    }
  }
}
