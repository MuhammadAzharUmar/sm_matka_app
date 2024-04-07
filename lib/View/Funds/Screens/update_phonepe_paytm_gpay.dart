// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/fund_appbar_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class UpdatePhonepeGpayPaytmScreen extends StatefulWidget {
  const UpdatePhonepeGpayPaytmScreen(
      {super.key,
      required this.screenTitle,
      required this.logoUrl,
      required this.logoTitle,
      required this.logoSubtitle});
  final String screenTitle;
  final String logoUrl;
  final String logoTitle;
  final String logoSubtitle;
  @override
  State<UpdatePhonepeGpayPaytmScreen> createState() =>
      _UpdatePhonepeGpayPaytmScreenState();
}

class _UpdatePhonepeGpayPaytmScreenState
    extends State<UpdatePhonepeGpayPaytmScreen> {
  TextEditingController accountNoContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
      return BlocBuilder<UserStatusCubit, UserStatusModel>(
          builder: (context, userStatus) {
        // update previous number of user
        if (widget.screenTitle == "Phone Pe") {
          accountNoContoller.text = user.data.phonepeMobileNo;
        } else if (widget.screenTitle == "PayTm") {
          accountNoContoller.text = user.data.paytmMobileNo;
        } else if (widget.screenTitle == "Google Pay") {
          accountNoContoller.text = user.data.gpayMobileNo;
        }
        return Scaffold(
          backgroundColor: kWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size(double.maxFinite, 56),
            child: FundAppBarWidget(
              title: widget.screenTitle,
              points: userStatus.data.availablePoints,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //text field
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                      gradient: kblueGradient,
                      borderRadius: kSmallBorderRadius,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: klightGreyGradient),
                          height: 80,
                          width: 80,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 80,
                                width: 80,
                                child: Lottie.asset(
                                  "assets/General/animation.json",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  widget.logoUrl,
                                  width: 36,
                                  height: 36,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.logoTitle,
                          style: kMediumCaptionTextStyle.copyWith(
                              color: k2ndColor, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.logoSubtitle,
                          style: kMediumCaptionTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InputTextFieldWidget(
                            controller: accountNoContoller,
                            labelText: "${widget.screenTitle} Number",
                          ),
                        ),
                      ],
                    ),
                  ),

                  //button
                  Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: KLoginButton(
                            title: "Submit",
                            onPressed: () async {
                              Map<String, dynamic> jsonData = {};
                              if (widget.screenTitle == "Phone Pe") {
                                jsonData =
                                    await HttpRequests.updatePhonepeRequest(
                                  context: context,
                                  token: user.token,
                                  phonepe: accountNoContoller.text.trim(),
                                );
                              } else if (widget.screenTitle == "PayTm") {
                                jsonData =
                                    await HttpRequests.updatePaytmRequest(
                                  context: context,
                                  token: user.token,
                                  paytm: accountNoContoller.text.trim(),
                                );
                              } else if (widget.screenTitle == "Google Pay") {
                                jsonData = await HttpRequests.updateGPayRequest(
                                  context: context,
                                  token: user.token,
                                  gPay: accountNoContoller.text.trim(),
                                );
                              }
                              if (jsonData["code"] == "100" &&
                                  jsonData["status"] == "success") {
                                final jsonNewUser =
                                    await HttpRequests.getUserDetailsRequest(
                                        context: context, token: user.token);
                                context.read<UserCubit>().updateAppUser(
                                      UserModel.fromJson(
                                        json: jsonNewUser,
                                        token: user.token,
                                      ),
                                    );

                                SnackBarMessage.simpleSnackBar(
                                  text: "Successfully Updated",
                                  context: context,
                                );
                                Future.delayed(const Duration(seconds: 1)).then(
                                    (value) => Navigator.of(context).pop());
                              }
                            },
                            gradient: kblueGradient,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
