// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

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
import 'package:sm_matka/View/Home/Widgets/home_init_function.dart';
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

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                forgotPasswordcaller: "signup",
                phoneNumber: mobile,
              ),
            ),
          );
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChangePasswordPage(
                token: jsonData["data"]["token"],
                mobile: mobile,
                caller: caller,
              ),
            ),
          );
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
          String pinToken = jsonData["data"]["token"].toString();
          // print("pin token 1= $pinToken ______________________________");
          if (pinToken != "" && pinToken.isNotEmpty) {
            await preferences.setString("userToken", pinToken);
            await HomeInitFunction.initFunctionHome(context: context);
            await Future.delayed(const Duration(milliseconds: 500))
                .then((value) {
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
            });
          } else {
            await preferences.clear();
            Navigator.of(context).popUntil(
              (route) => route.isFirst,
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
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
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                forgotPasswordcaller: "password",
                phoneNumber: mobile,
              ),
            ),
          );
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                forgotPasswordcaller: "pin",
                phoneNumber: mobile,
              ),
            ),
          );
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
          //update token
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("userToken", jsonData["data"]["token"]);
          await Future.delayed(const Duration(seconds: 1)).then((value) {
            if (navigateTo == "home") {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          });
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }

  static Future<AppDetailsModel> appDetialsRequest(
      {required BuildContext context}) async {
    try {
      var request = http.Request('POST', Uri.parse('$baseUrl/app_details'));

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        AppDetailsModel appDetailsModel = AppDetailsModel.fromJson(jsonData);

        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return appDetailsModel;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
      return {};
    }
  }

  static Future<Map<String, dynamic>> getUserStatusRequest(
      {required BuildContext context, required String token}) async {
    try {
      var headers = {'token': token};
      var request = http.Request('POST', Uri.parse('$baseUrl/user_status'));

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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
      return {};
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
      return {};
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
              .toString()
              .toLowerCase()
              .contains("No Record Found".toLowerCase()) ||
          e
              .toString()
              .toLowerCase()
              .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          // print(jsonData);
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
              .toString()
              .toLowerCase()
              .contains("No Record Found".toLowerCase()) ||
          e
              .toString()
              .toLowerCase()
              .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
              .toString()
              .toLowerCase()
              .contains("Please Select Token".toLowerCase()) ||
          e.toString().toLowerCase().contains("OK".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
      return {};
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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
      return {};
    }
  }

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
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
              .toString()
              .toLowerCase()
              .contains("No Record Found".toLowerCase()) ||
          e
              .toString()
              .toLowerCase()
              .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
              .toString()
              .toLowerCase()
              .contains("No Record Found".toLowerCase()) ||
          e
              .toString()
              .toLowerCase()
              .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
      return {};
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
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
              .toString()
              .toLowerCase()
              .contains("No Record Found".toLowerCase()) ||
          e
              .toString()
              .toLowerCase()
              .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
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
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );

          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
              .toString()
              .toLowerCase()
              .contains("No Record Found".toLowerCase()) ||
          e
              .toString()
              .toLowerCase()
              .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }

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
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
          .toString()
          .toLowerCase()
          .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }

/* payment configuration api  */
  static Future<Map<String, dynamic>> paymentConfigRequest({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var headers = {'token': token};
      var request = http.Request(
        'POST',
        Uri.parse(
          'http://development.smapidev.co.in/api/Api/payment_config',
        ),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
          .toString()
          .toLowerCase()
          .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> indicpayPayemntRequest({
    required BuildContext context,
    required String token,
    required String amount,
    required String authorization,
  }) async {
    try {
      var headers = {'token': token, 'Authorization': 'Basic Og=='};
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://development.smapidev.co.in/api/Api/payment_request'));
      request.fields.addAll({'amount': amount, 'method_name': 'indicpay'});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
          .toString()
          .toLowerCase()
          .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> paysantsPayemntRequest({
    required BuildContext context,
    required String token,
    required String amount,
    required String authorization,
  }) async {
    try {
      var headers = {'token': token, 'Authorization': 'Basic Og=='};
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://development.smapidev.co.in/api/Api/payment_request'));
      request.fields.addAll({'amount': amount, 'method_name': 'pay_sants'});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
              if (kDebugMode) {
                print("===============================\n$jsonData\n====================================");
              }

        errorCodeFromApi = jsonData["code"];
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
          .toString()
          .toLowerCase()
          .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> payemntReceiveRequest({
    required BuildContext context,
    required String token,
    required String amount,
    required String authorization,
    required String status,
    required String method,
    required String transcationId,
    required String methodDetails,
    required String screenshot,
  }) async {
    try {
      var headers = {'token': token, 'Authorization': 'Basic Og=='};
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://development.smapidev.co.in/api/Api/payment_receive'));
      request.fields.addAll({
        'amount': amount,
        'method_name': method,
        'transaction_id': transcationId,
        'status': status,
        'method_details': methodDetails,
        'screenshot': '',
      });
//

      if (screenshot != '' && screenshot.isNotEmpty) {
        var file = File(screenshot);
        if (await file.exists()) {
          Uint8List fileBytes = await file.readAsBytes();

          request.files.add(http.MultipartFile.fromBytes(
            'screenshot',
            fileBytes,
            filename: file.path.split('/').last,
          ));
        } else {
          if (kDebugMode) {
            print('File does not exist at path: $screenshot');
          }
        }
      } else {
        request.files.add(http.MultipartFile.fromString(
          'screenshot',
          '',
        ));
      }
      //
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();

        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
          .toString()
          .toLowerCase()
          .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> paysantsStatusRequest({
    required BuildContext context,
    required String token,
    required String amount,
    required String authorization,
  }) async {
    try {
      var headers = {
        'Authorization': 'Bearer 2Jxbn6iaodPhEVJ74zbADEQMxKksmrxrTvq0tu1M'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://payment.paysants.in/api/get/transaction'));
      request.fields.addAll({'order_id': 'SPORDQ7PQ1713685550MFPU2U'});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
          .toString()
          .toLowerCase()
          .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }

  static Future<Map<String, dynamic>> indicpayStatusRequest({
    required BuildContext context,
    required String token,
    required String amount,
    required String authorization,
  }) async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://indicpay.in/api/newc/checkstatus?txnid=6624b89101750'));

      http.StreamedResponse response = await request.send();
      //code status for error check
      String errorCodeFromApi = "";
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = json.decode(responseBody);
        errorCodeFromApi = jsonData["code"];
        errorCodeFromApi = jsonData["code"];
        if (jsonData["status"] == "success") {
          SnackBarMessage.centeredSuccessSnackbar(
            text: jsonData["message"].toString(),
            context: context,
          );
          return jsonData;
        } else if (response.statusCode == 505 || errorCodeFromApi == "505") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
          throw jsonData["message"].toString();
        } else {
          throw jsonData["message"].toString();
        }
      } else {
        throw response.reasonPhrase!;
      }
    } catch (e) {
      if (e
          .toString()
          .toLowerCase()
          .contains("Please Select Token".toLowerCase())) {
        rethrow;
      }
      return SnackBarMessage.centeredSnackbar(
        text: e is SocketException
            ? "Please check your internet connection and try again."
            : "$e",
        context: context,
      );
    }
  }
}
