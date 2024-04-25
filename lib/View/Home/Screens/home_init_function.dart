// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/View/Auth/Screens/login.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class HomeInitFunction {
  static Future<void> initFunctionHome({required BuildContext context}) async {
   
     
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = "${preferences.getString("userToken")}";
      if (token != "") {
        final data = await HttpRequests.getUserDetailsRequest(
          context: context,
          token: token,
        );
        UserModel user = UserModel.fromJson(json: data, token: token);
        BlocProvider.of<UserCubit>(context).updateAppUser(user);
        final statusdata = await HttpRequests.getUserStatusRequest(
          context: context,
          token: token,
        );
        UserStatusModel userStatus = UserStatusModel.fromJson(statusdata);
        BlocProvider.of<UserStatusCubit>(context)
            .updateAppUserStatus(userStatus);
      } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
  
    
  }
}
