import 'package:flutter/material.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';

class MenuItem {
  static List<Map<String, dynamic>> menuItem = [
    {
      'icon': Icons.currency_bitcoin,
      'title': 'Game Rates',
      'onTap': (BuildContext context) async {
        // await LaunchCustomUrls.launchURL(
        //     url: "https://www.buymeacoffee.com/codebuildersapps");
      }
    },

    {
      'icon': Icons.play_circle_outline,
      'title': 'How to Play',
      'onTap': (BuildContext context) async {
        // await LaunchCustomUrls.launchURL(
        //     url:
        //         "https://play.google.com/store/apps/dev?id=5699969007496830224");
      }
    },
    {
      'icon': Icons.contact_phone_outlined,
      'title': 'Contact Us',
      'onTap': (BuildContext context) async {
        // await LaunchCustomUrls.launchURL(
        //     url:
        //         'https://play.google.com/store/apps/details?id=text.wordcounter.notes');
      }
    },
    {
      'icon': Icons.share,
      'title': 'Share With Friends',
      'onTap': (BuildContext context) async {
        // await Share.share(
        //     'https://play.google.com/store/apps/details?id=text.wordcounter.notes');
      }
    },
    {
      'icon': Icons.star_border,
      'title': 'Rate App',
      'onTap': (BuildContext context) async {
        await LaunchCustomUrls.launchURL(
            url:
                'https://play.google.com/store/apps/details?id=text.wordcounter.notes');
      }
    },
    {
      'icon': Icons.password,
      'title': 'Change Password',
      'onTap': (BuildContext context) async {
        // await LaunchCustomUrls.launchURL(
        //     url:
        //         'https://codebuildersapp.blogspot.com/2022/06/privacy-policy.html?m=1');
      }
    },
  ];
}


/**
 * home
 * profile
 * funds
 * histor
 * game rates
 * how to play
 * contact us
 * share
 * rate app
 * pass
 */