// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Screens/change_password.dart';
import 'package:sm_matka/View/Auth/Screens/login.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Settings/Screens/contact_us.dart';
import 'package:sm_matka/View/Settings/Screens/game_rates.dart';
import 'package:sm_matka/View/Settings/Screens/how_to_play.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';

class MenuItem {
  static List<Map<String, dynamic>> menuItem = [
    {
      'icon': Icons.currency_bitcoin,
      'title': 'Game Rates',
      'onTap': (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GamesRates(),
          ),
        );
      }
    },
    {
      'icon': Icons.play_circle_outline,
      'title': 'How to Play',
      'onTap': (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HowToPlay(),
          ),
        );
      }
    },
    {
      'icon': Icons.contact_phone_outlined,
      'title': 'Contact Us',
      'onTap': (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ContactUs(),
          ),
        );
      }
    },
    {
      'icon': Icons.share,
      'title': 'Share With Friends',
      'onTap': (BuildContext context) async {
        final appdetails = context.read<AppDetailsCubit>().state;
        final shareMsgLink =
            '${appdetails.data.adminMessage}\nVia - ${appdetails.data.appLink}';
        await Share.share(shareMsgLink);
      }
    },
    {
      'icon': Icons.star_border,
      'title': 'Rate App',
      'onTap': (BuildContext context) async {
        final appdetails = context.read<AppDetailsCubit>().state;
        await LaunchCustomUrls.launchURL(
          url: appdetails.data.appLink,
        );
      }
    },
    {
      'icon': Icons.password,
      'title': 'Change Password',
      'onTap': (BuildContext context) async {
        UserModel user = context.read<UserCubit>().state;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChangePasswordPage(
              token: user.token,
              mobile: user.data.mobile,
              caller: "Password",
              navigateTo: "home",
            ),
          ),
        );
      }
    },
    {
      'icon': Icons.power_settings_new,
      'title': 'Log Out',
      'onTap': (BuildContext context) async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              insetPadding: const EdgeInsets.all(0),
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                decoration: const BoxDecoration(
                    color: kWhiteColor, borderRadius: kLargeBorderRadius),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Logout",
                      style: kLargeTextStyle.copyWith(
                          color: kBlue1Color, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Are you sure,\nyou want to logout the game?",
                      style: kSmallTextStyle.copyWith(
                          color: kBlue1Color, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: KLoginButton(
                              title: "No",
                              gradient: klightGreyGradient,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: KLoginButton(
                              title: "Yes",
                              gradient: kblueGradient,
                              onPressed: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.clear();
                                BlocProvider.of<UserCubit>(context)
                                    .updateAppUser(UserModel.fromJson(
                                        json: {}, token: ""));
                                BlocProvider.of<UserStatusCubit>(context)
                                    .updateAppUserStatus(
                                        UserStatusModel.fromJson({}));
                                BlocProvider.of<AppDetailsCubit>(context)
                                    .updateAppDetails(
                                        AppDetailsModel.fromJson({}));
                                SnackBarMessage.centeredSuccessSnackbar(
                                    text: "Logout Successfully",
                                    context: context);
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    },
  ];
}
