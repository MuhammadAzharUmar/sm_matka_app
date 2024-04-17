// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/fund_appbar_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/payment_method_dropdown_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/withdraw_fund_update_payment_method_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/withdraw_statement_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class WithdrawFundScreen extends StatefulWidget {
  const WithdrawFundScreen({super.key});

  @override
  State<WithdrawFundScreen> createState() => _WithdrawFundScreenState();
}

class _WithdrawFundScreenState extends State<WithdrawFundScreen> {
  TextEditingController pointsController = TextEditingController();
  int dropDownValue = 0;
  String selectedPaymentMethod = "";
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
                title: "Withdraw Points",
                points: userStatus.data.availablePoints,
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AddFundNoticeWidget(
                      caller: "withdraw",
                      addfundNotice: appdetailsModel.data.withdrawNotice,
                    ),
                    Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                          borderRadius: kSmallBorderRadius),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: const BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: kSmallBorderRadius,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/General/clock.png",
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Time: ${appdetailsModel.data.withdrawOpenTime} - ${appdetailsModel.data.withdrawCloseTime}",
                              style: kMediumCaptionTextStyle.copyWith(
                                  color: kBlue1Color),
                            )
                          ],
                        ),
                      ),
                    ),

                    //update payment method
                    const WithdrawFundUpdatePaymentMethodWidget(),
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
                            keyboardType: TextInputType.number,

                            controller: pointsController,
                            labelText: "Enter Points",
                          ),
                          PaymentMethodDropdownWidget(
                            dropDownValue: dropDownValue,
                            selectedDropDownValue: selectedPaymentMethod,
                            onChange: (newMethod) {
                              setState(() {
                                // dropDownValue=
                                selectedPaymentMethod = newMethod;
                              });
                            },
                          ),
                          
                          const SizedBox(
                            height: 10,
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
                              title: "Submit Request",
                              onPressed: () async {
                                // if (dropDownValue==0) {
                                //   SnackBarMessage.centeredSnackbar(text: "please select payment method", context: context);
                                // } else {
                                await HttpRequests.withdrawRequest(
                                    context: context,
                                    token: user.token,
                                    points: pointsController.text.trim(),
                                    method: selectedPaymentMethod,
                                    );
                                // }
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
                    const WithdrawStatementWidget()
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
