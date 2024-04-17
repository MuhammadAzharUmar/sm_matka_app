import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/View/Auth/Screens/login_pin.dart';
import 'package:sm_matka/View/Auth/Screens/signup.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("userToken") ?? "";
      if (token != "") {
       
        final data = await HttpRequests.getUserDetailsRequest(
          // ignore: use_build_context_synchronously
          context: context,
          token: token,
        );
        UserModel user = UserModel.fromJson(json: data, token: token);
        // ignore: use_build_context_synchronously
        BlocProvider.of<UserCubit>(context).updateAppUser(user);
        final statusdata = await HttpRequests.getUserStatusRequest(
          // ignore: use_build_context_synchronously
          context: context,
          token: token,
        );
        UserStatusModel userStatus = UserStatusModel.fromJson(statusdata);
        // ignore: use_build_context_synchronously
        BlocProvider.of<UserStatusCubit>(context)
            .updateAppUserStatus(userStatus);
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => LoginPin(
                token: token,
                // currentIndex: 0,
              ),
            ));
      } else {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Container(
          // decoration:const BoxDecoration(gradient: kCustomGradient),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(50),
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage('assets/Logo/logo.png'))),
          )),
    );
  }
}
