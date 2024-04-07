import 'package:flutter/material.dart';
import 'package:sm_matka/View/Funds/Screens/add_fund_page.dart';
import 'package:sm_matka/View/Funds/Screens/bank_details_update.dart';
import 'package:sm_matka/View/Funds/Screens/transfer_points_screen.dart';
import 'package:sm_matka/View/Funds/Screens/update_phonepe_paytm_gpay.dart';
import 'package:sm_matka/View/Funds/Screens/withdraw_fund_screen.dart';

class FundList {
  static List<Map<String, dynamic>> fundList = [
    {
      "title": "Add",
      "img": "assets/Fund/add.png",
      "onTap": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddFundPage(),
          ),
        );
      },
    },
    {
      "title": "Withdraw",
      "img": "assets/Fund/withdraw.png",
      "onTap": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WithdrawFundScreen(),
          ),
        );
      },
    },
    {
      "title": "Transfer",
      "img": "assets/Fund/transfer.png",
      "onTap": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TransferPointsScreen(),
          ),
        );
      },
    },
    {
      "title": "Bank",
      "img": "assets/Fund/bank.png",
      "onTap": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BankDetailsUpdateScreen(),
          ),
        );
      },
    },
    {
      "title": "PhonePe",
      "img": "assets/Fund/phonepe.png",
      "onTap": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UpdatePhonepeGpayPaytmScreen(
              screenTitle: "Phone Pe",
              logoUrl: "assets/Fund/phonepe.png",
              logoTitle: "Hey, Whats your PhonePe number?",
              logoSubtitle: "Enter your PhonePe number to use in withdrawel.",
            ),
          ),
        );
      },
    },
    {
      "title": "Paytm",
      "img": "assets/Fund/paytm.png",
      "onTap": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UpdatePhonepeGpayPaytmScreen(
              screenTitle: "PayTm",
              logoUrl: "assets/Fund/paytm.png",
              logoTitle: "Hey, Whats your PayTm number?",
              logoSubtitle: "Enter your PayTm number to use in withdrawel.",
            ),
          ),
        );
      },
    },
    {
      "title": "GPay",
      "img": "assets/Fund/gpay.png",
      "onTap": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UpdatePhonepeGpayPaytmScreen(
              screenTitle: "Google Pay",
              logoUrl: "assets/Fund/gpay.png",
              logoTitle: "Hey, Whats your Google Pay number?",
              logoSubtitle: "Enter your Google Pay number to use in withdrawel.",
            ),
          ),
        );
      },
    },
  ];
}
