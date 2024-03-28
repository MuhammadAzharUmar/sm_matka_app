import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/View/Auth/Screens/signup.dart';
import 'package:sm_matka/View/Home/Screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () async{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      String token= preferences.getString("userToken").toString();
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) =>token!=""?const MainPage(currentIndex: 0,):  const SignupPage(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kBlueColor,
      body:  Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(50),
        child:const Image(image: AssetImage('assets/Logo/logo.png'))),
    );
  }
}