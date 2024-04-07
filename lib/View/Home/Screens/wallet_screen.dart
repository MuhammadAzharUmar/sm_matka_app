// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Screens/funds.dart';
import 'package:sm_matka/View/Home/Widgets/wallet_statement_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController pointsController = TextEditingController();
  int dropDownValue = 0;
  String selectedPaymentMethod = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStatusCubit, UserStatusModel>(
        builder: (context, userStatus) {
      return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: kWhiteColor,
              )),
          backgroundColor: kBlue1Color,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Wallet",
            style: kMediumTextStyle.copyWith(
                color: kWhiteColor, fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      gradient: klightGreyGradient,
                      borderRadius: kMediumBorderRadius),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/General/coinsWallet.png",
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Balance",
                              style: kMediumCaptionTextStyle.copyWith(
                                  color: kBlue1Color,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              userStatus.data.availablePoints,
                              style: kSmallTextStyle.copyWith(
                                  color: kBlue1Color,
                                  fontWeight: FontWeight.w700),
                            ),
                            KLoginButton(
                              title: "Funds",
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Funds(),
                                  ),
                                );
                              },
                              gradient: kblueGradient,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: .5,
                  color: kBlue1Color,
                  indent: 20,
                  endIndent: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Transcations",
                      style: kLargeTextStyle.copyWith(
                        color: kBlue1Color,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                const WalletStatementWidget()
              ],
            ),
          ),
        ),
      );
    });
  }
}
