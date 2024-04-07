import 'package:flutter/material.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/View/Funds/Screens/add_fund_page.dart';
import 'package:sm_matka/View/Funds/Screens/withdraw_fund_screen.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';

class FundWithdrawChatCallButtonList {
  static List<Map<String, dynamic>> fundWithdrawChatCallButtonList = [
    {
      'img': "assets/General/addfund.png",
      'title': 'Add Fund',
      'onTap': (BuildContext context, ContactDetails contactDetails) async {
         Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddFundPage(),
          ),
        );
      }
    },
    {
      'img': "assets/General/withdraw.png",
      'title': 'Withdraw',
      'onTap': (BuildContext context, ContactDetails contactDetails) async {
       Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WithdrawFundScreen(),
          ),
        );
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
