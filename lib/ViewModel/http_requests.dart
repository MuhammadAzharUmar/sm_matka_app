// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/View/Auth/Screens/change_password.dart';
import 'package:sm_matka/View/Auth/Screens/login.dart';
import 'package:sm_matka/View/Auth/Screens/login_pin.dart';
import 'package:sm_matka/View/Auth/Screens/otp_verification.dart';
import 'package:sm_matka/View/Auth/Screens/signup.dart';
import 'package:sm_matka/View/Home/Screens/main_screen.dart';

class HttpRequests {
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                forgotPasswordcaller: "signup",
                phoneNumber: mobile,
              ),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static verifyUserRequest({
    required String mobile,
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
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
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
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
          String loginToken = jsonData["data"]["token"];
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginPin(
                token: loginToken,
              ),
            ),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static loginPinRequest(
      {required String loginToken,
      required String pin,
      required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var headers = {'token': loginToken};
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          String pinToken = jsonData["data"]["token"];
          if (pinToken != "" && pinToken.isNotEmpty) {
            await preferences.setString("userToken", pinToken);
            await HttpRequests.getUserDetailsRequest(
                context: context, token: pinToken);

            Navigator.of(context).popUntil(
              (route) => route.isFirst,
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainPage(
                  currentIndex: 0,
                ),
              ),
            );
          }
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

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
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

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
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static forgotPasswordVerifyRequest(
      {required String mobile,
      required String token,
      required String password,
      required String navigateTo,
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
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          //update token
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("userToken", jsonData["data"]["token"]);

          if (navigateTo == "home") {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<AppDetailsModel> appDetialsRequest(
      {required BuildContext context}) async {
    try {
      var request = http.Request('POST', Uri.parse('$baseUrl/app_details'));

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        AppDetailsModel appDetailsModel = AppDetailsModel.fromJson(jsonData);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return appDetailsModel;
        } else {
          if (jsonData["message"] == "Please Login First" ||
              jsonData["code"] == "505" ||
              jsonData["code"] == "400" ||
              jsonData["message"] == "Invalid Access") {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
          }
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> gameRatesRequest(
      {required BuildContext context, required String token}) async {
    try {
      var headers = {'token': token};
      var request = http.Request('POST', Uri.parse('$baseUrl/game_rate_list'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> howToPlayRequest(
      {required BuildContext context, required String token}) async {
    try {
      var headers = {'token': token};
      var request = http.Request('POST', Uri.parse('$baseUrl/how_to_play'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          // return jsonData;
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> getUserDetailsRequest(
      {required BuildContext context, required String token}) async {
    try {
      var headers = {'token': token};
      var request =
          http.Request('POST', Uri.parse('$baseUrl/get_user_details'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          return jsonData;
        } else {
          if (jsonData["message"] == "Please Login First" ||
              jsonData["code"] == "505" ||
              jsonData["code"] == "400" ||
              jsonData["message"] == "Invalid Access") {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
            return {};
          }
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> getUserStatusRequest(
      {required BuildContext context, required String token}) async {
    try {
      var headers = {'token': token};
      var request = http.Request('POST', Uri.parse('$baseUrl/user_status'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          return jsonData;
        } else {
          if (jsonData["message"] == "Please Login First" ||
              jsonData["code"] == "400" ||
              jsonData["status"] == "error" ||
              jsonData["message"] == "Not Verified" ||
              jsonData["code"] == "505") {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
          }
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          // return {};
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> updateProfileRequest({
    required BuildContext context,
    required String token,
    required String email,
    required String name,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/update_profile'));
      request.fields.addAll({'email': email, 'name': name});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> addFundRequest({
    required BuildContext context,
    required String token,
    required String points,
    required String transStatus,
    required String transId,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/add_fund'));
      request.fields.addAll(
          {'points': points, 'trans_status': transStatus, 'trans_id': transId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> updatePhonepeRequest({
    required BuildContext context,
    required String token,
    required String phonepe,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/update_phonepe'));
      request.fields.addAll({'phonepe': phonepe});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> updateBankDetailsRequest({
    required BuildContext context,
    required String token,
    required String accHolderName,
    required String accNumber,
    required String ifscCode,
    required String bankName,
    required String branchAddress,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/update_bank_details'));
      request.fields.addAll({
        'account_holder_name': accHolderName,
        'account_no': accNumber,
        'ifsc_code': ifscCode,
        'bank_name': bankName,
        'branch_address': branchAddress,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return {};
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> updateGPayRequest({
    required BuildContext context,
    required String token,
    required String gPay,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/update_gpay'));
      request.fields.addAll({
        'gpay': gPay,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> updatePaytmRequest({
    required BuildContext context,
    required String token,
    required String paytm,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/update_paytm'));
      request.fields.addAll({'paytm': paytm});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> withdrawRequest({
    required BuildContext context,
    required String token,
    required String points,
    required String method,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/withdraw'));
      request.fields.addAll({
        'points': points,
        'method': method,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return {};
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> withdrawStatementRequest({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.Request('POST', Uri.parse('$baseUrl/withdraw_statement'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> walletStatementRequest({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.Request('POST', Uri.parse('$baseUrl/wallet_statement'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        SnackBarMessage.centeredSnackbar(
          text: response.reasonPhrase.toString(),
          context: context,
        );
        return {};
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> transferVerifyRequest({
    required BuildContext context,
    required String token,
    required String userNumer,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/transfer_verify'));
      request.fields.addAll({
        'user_number': userNumer,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> transferPointsRequest({
    required BuildContext context,
    required String token,
    required String userNumber,
    required String points,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/transfer_points'));
      request.fields.addAll({
        'points': points,
        'user_number': userNumber,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return {};
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> winHistoryRequest({
    required BuildContext context,
    required String token,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/win_history'));
      request.fields.addAll({
        'from_date': fromDate,
        'to_date': toDate,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> bidHistoryRequest({
    required BuildContext context,
    required String token,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/bid_history'));
      request.fields.addAll({
        'from_date': fromDate,
        'to_date': toDate,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          // print(jsonData);
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> mainGameListRequest({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.Request('POST', Uri.parse('$baseUrl/main_game_list'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> placeBidRequest(
      {required BuildContext context,
      required String token,
      required List<Map<String, dynamic>> list}) async {
    try {
      var headers = {
        'token': token,
      };

      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/place_bid'));
      request.fields.addAll({'game_bids': '{"bids": ${jsonEncode(list)}}'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return {};
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> starlineGameRequest({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.Request('POST', Uri.parse('$baseUrl/starline_game'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          return SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> starlinePlaceBidRequest({
    required BuildContext context,
    required String token,
    required List<Map<String, dynamic>> list,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/starline_place_bid'));
      request.fields.addAll({'game_bids': '{"bids": ${jsonEncode(list)}}'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          SnackBarMessage.centeredSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return {};
        }
      } else if (response.statusCode == 505) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  ///************* */
  static Future<Map<String, dynamic>> starlineBidHistoryRequest({
    required BuildContext context,
    required String token,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/starline_bid_history'));
      request.fields.addAll({
        'from_date': fromDate,
        'to_date': toDate,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          throw jsonData["message"].toString();
        }
      } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> starlineWinHistoryRequest({
    required BuildContext context,
    required String token,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/starline_win_history'));
      request.fields.addAll({
        'from_date': fromDate,
        'to_date': toDate,
      });
      request.headers.addAll(headers);
//code status for error check
      String errorCodeFromApi = "";
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          return jsonData;
        } else {
          throw jsonData["message"].toString();
        }
      } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> galiDisawarGameRequest({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var headers = {'token': token};
      var request =
          http.Request('POST', Uri.parse('$baseUrl/gali_disawar_game'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          // SnackBarMessage.centeredSnackbar(
          //   text: jsonData["message"].toString(),
          //   context: context,
          // );
          // return {};
          throw jsonData["message"].toString();
        }
      } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> galiDisawarPlaceBidRequest({
    required BuildContext context,
    required String token,
    required List<Map<String, dynamic>> list,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/gali_disawar_place_bid'));
      request.fields.addAll({'game_bids': '{"bids": ${jsonEncode(list)}}'});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          // SnackBarMessage.centeredSnackbar(
          //   text: jsonData["message"].toString(),
          //   context: context,
          // );
          // return {};
          throw jsonData["message"].toString();
        }
      } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> galiDisawarBidHistoryRequest({
    required BuildContext context,
    required String token,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/gali_disawar_bid_history'));
      request.fields.addAll({
        'from_date': fromDate,
        'to_date': toDate,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          // return SnackBarMessage.centeredSnackbar(
          //   text: jsonData["message"].toString(),
          //   context: context,
          // );
          throw jsonData["message"].toString();
        }
      } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> galiDisawarWinHistoryRequest({
    required BuildContext context,
    required String token,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/gali_disawar_win_history'));
      request.fields.addAll({
        'from_date': fromDate,
        'to_date': toDate,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          return jsonData;
        } else {
          throw jsonData["message"].toString();
        }
      } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e.toString(),
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> readNotificationRequest({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/read_notification'));
      request.fields.addAll({'readnoti': 'true'});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else {
          throw jsonData["message"].toString();
        }
      } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
        throw response.reasonPhrase.toString();
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: "$e",
        context: context,
      );
    }
  }
}
