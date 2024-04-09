// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
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
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class TransferPointsScreen extends StatefulWidget {
  const TransferPointsScreen({super.key});

  @override
  State<TransferPointsScreen> createState() => _TransferPointsScreenState();
}

class _TransferPointsScreenState extends State<TransferPointsScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  bool isVerified = false;
  String verifiedUserName = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
      return BlocBuilder<AppDetailsCubit, AppDetailsModel>(
          builder: (context, appdetailsModel) {
        return BlocBuilder<UserStatusCubit, UserStatusModel>(
            builder: (context, userStatus) {
          return Scaffold(
            backgroundColor: kWhiteColor,
            appBar: PreferredSize(
              preferredSize: const Size(double.maxFinite, 56),
              child: FundAppBarWidget(
                title: "Transfer Points",
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 2),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: const BoxDecoration(
                        gradient: kblueGradient,
                        borderRadius: kSmallBorderRadius,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputTextFieldWidget(
                            controller: mobileController,
                            labelText: "Mobile",
                          ),
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                isVerified
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.verified,
                                            color: Color.fromARGB(
                                                255, 20, 240, 27),
                                            size: 14,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            verifiedUserName,
                                            style: kMediumCaptionTextStyle
                                                .copyWith(color: kWhiteColor),
                                          )
                                        ],
                                      )
                                    : Container(
                                        height: 10,
                                      ),
                                KLoginButton(
                                    title: "Verify",
                                    onPressed: () async {
                                      final jsonData = await HttpRequests
                                          .transferVerifyRequest(
                                        context: context,
                                        token: user.token,
                                        userNumer: mobileController.text.trim(),
                                      );
                                      if (jsonData["code"] == "100" &&
                                          jsonData["status"] == "success") {
                                        setState(() {
                                          isVerified = true;
                                          verifiedUserName =
                                              jsonData["data"]["name"];
                                        });
                                      }
                                    })
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isVerified
                              ? InputTextFieldWidget(
                                  controller: pointsController,
                                  labelText: "Points",
                                )
                              : Container(
                                  height: 0,
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
                                final jsonData =
                                    await HttpRequests.transferPointsRequest(
                                  context: context,
                                  token: user.token,
                                  points: pointsController.text.trim(),
                                  userNumber: mobileController.text.trim(),
                                );
                                if (jsonData["code"] == "100" &&
                                    jsonData["status"] == "success") {
                                  final jsonNewStatus =
                                      await HttpRequests.getUserStatusRequest(
                                          context: context, token: user.token);
                                  context
                                      .read<UserStatusCubit>()
                                      .updateAppUserStatus(
                                          UserStatusModel.fromJson(
                                              jsonNewStatus));
                                  setState(() {
                                    isVerified = false;
                                    verifiedUserName = "";
                                  });
                                  SnackBarMessage.simpleSnackBar(
                                    text: "Successfully Transferred",
                                    context: context,
                                  );
                                }
                              },
                              gradient: kblueGradient,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: .5,
                      color: kBlue1Color,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
    });
  }
}