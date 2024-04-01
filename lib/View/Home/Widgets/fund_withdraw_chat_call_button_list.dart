import 'package:flutter/material.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';

class FundWithdrawChatCallButtonList {
  static List<Map<String, dynamic>> fundWithdrawChatCallButtonList = [
    {
      'img': "assets/General/addfund.png",
      'title': 'Add Fund',
      'onTap': (BuildContext context, ContactDetails contactDetails) async {
        // await LaunchCustomUrls.launchURL(
        //     url: "https://www.buymeacoffee.com/codebuildersapps");
      }
    },
    {
      'img': "assets/General/withdraw.png",
      'title': 'Withdraw',
      'onTap': (BuildContext context, ContactDetails contactDetails) async {
        // await LaunchCustomUrls.launchURL(
        //     url:
        //         "https://play.google.com/store/apps/dev?id=5699969007496830224");
      }
    },
    {
      'img': "assets/General/whatsapp.png",
      'title': 'Chat Now',
      'onTap': (BuildContext context, ContactDetails contactDetails) async {
        await LaunchCustomUrls.launchURL(
            url: 'https://wa.me/${contactDetails.whatsappNo}');
      }
    },
    {
      'img': "assets/General/call.png",
      'title': 'Call Now',
      'onTap': (BuildContext context, ContactDetails contactDetails) async {
        await LaunchCustomUrls.launchURL(
            url:
                'tel:${contactDetails.mobileNo1 != "" ? contactDetails.mobileNo1 : contactDetails.mobileNo2}');
      }
    },
  ];
}
