import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/View/Auth/Screens/change_password.dart';
import 'package:sm_matka/View/Auth/Screens/signup.dart';
import 'package:sm_matka/View/Settings/Screens/contact_us.dart';
import 'package:sm_matka/View/Settings/Screens/game_rates.dart';
import 'package:sm_matka/View/Settings/Screens/how_to_play.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

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
        await Share.share('app link will be shared');
      }
    },
    {
      'icon': Icons.star_border,
      'title': 'Rate App',
      'onTap': (BuildContext context) async {
        await LaunchCustomUrls.launchURL(url: 'sm_matka');
      }
    },
    {
      'icon': Icons.password,
      'title': 'Change Password',
      'onTap': (BuildContext context) async {
        UserModel user=context.read<UserCubit>().state;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChangePasswordPage(
              token: user.token,
              mobile: user.data.mobile,
              caller: "Password",
            ),
          ),
        );
      }
    },
    {
      'icon': Icons.power_settings_new,
      'title': 'Log Out',
      'onTap': (BuildContext context) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("userToken", "");
        // ignore: use_build_context_synchronously
        Navigator.of(context).popUntil((route) => route.isFirst);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        );
      }
    },
  ];
}
