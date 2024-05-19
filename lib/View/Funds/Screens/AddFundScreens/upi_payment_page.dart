// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/payment_config_model.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/AddFundWidget/add_fund_payment_method_list.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/addfund_method_index.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/payment_config_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/upi_payment_method_active_index_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/UpiPaymentFunctions/upi_payment_function.dart';
import 'package:upi_india/upi_app.dart';

import '../../Widgets/AddFundWidget/ad_video_player.dart';

class UpiPaymentScreen extends StatelessWidget {
  const UpiPaymentScreen({
    super.key,
    required this.points,
  });
  final String points;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentConfigCubit, PaymentConfigModel>(
        builder: (context, paymentConfigModel) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AddFundNoticeWidget(
              heading: "UPI Notice",
              addfundNotice:
                  paymentConfigModel.data.availableMethodsDetails.upi.notice,
            ),
          ),
          SizedBox(
            height: 68,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/General/diamond.png",
                  width: 46,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      points,
                      style: kSmallTextStyle.copyWith(
                        color: kBlue1Color,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "Points",
                      style: kSmallTextStyle.copyWith(
                        color: kBlue1Color,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            "Selcet Payment Method",
            style: kMediumTextStyle.copyWith(
              color: kBlue1Color,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            shape:
                const RoundedRectangleBorder(borderRadius: kMediumBorderRadius),
            child: Container(
              decoration: const BoxDecoration(
                  color: kWhiteColor, borderRadius: kMediumBorderRadius),
              child: BlocBuilder<UPIpaymentMethodActiveIndexCubit, int>(
                  builder: (context, activeIndex) {
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      AddFundPaymentMethodList.upiPaymentMethodList.length,
                  itemBuilder: (context, index) {
                    return AddFundMethodWidget(
                      index: index,
                      selectedMethod: activeIndex,
                      url: AddFundPaymentMethodList.upiPaymentMethodList[index]
                          ["img"],
                      title: AddFundPaymentMethodList
                          .upiPaymentMethodList[index]["title"],
                      onPressed: (newMethodIndex) {
                        context
                            .read<UPIpaymentMethodActiveIndexCubit>()
                            .updateIndex(index);
                      },
                    );
                  },
                );
              }),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: KLoginButton(
                    title: "Submit",
                    loadingstate: AppLoadingStates.paymentSubmitButtonLoading,
                    gradient: kblueGradient,
                    onPressed: () async {
                      if (paymentConfigModel.data.availableMethodsDetails.amountConfiguration!="1") {
                        return SnackBarMessage.centeredSnackbar(text: "service unavailable, try again later", context: context,);
                      }
                      int selectedIndex = context
                          .read<UPIpaymentMethodActiveIndexCubit>()
                          .state;
                      if (selectedIndex == 0 ||
                          selectedIndex == 1 ||
                          selectedIndex == 2) {
                        context.read<AppLoadingCubit>().updateAppLoadingState(
                              AppLoadingStates.paymentSubmitButtonLoading,
                            );
                        try {
                          UserStatusModel userStatusModel =
                              context.read<UserStatusCubit>().state;
                          UpiApp app = AddFundPaymentMethodList
                              .upiPaymentMethodList[selectedIndex]["app"];
                          double enteredAmount = double.parse(points);
                          double upiLimitAmount = double.parse(
                              paymentConfigModel
                                  .data.availableMethodsDetails.upiLimit);
                          String upiId = enteredAmount > upiLimitAmount
                              ? paymentConfigModel.data.availableMethodsDetails
                                  .largeAmountUpi.upiId
                              : paymentConfigModel.data.availableMethodsDetails
                                  .smallAmountUpi.upiId;
                          String upiName = enteredAmount > upiLimitAmount
                              ? paymentConfigModel.data.availableMethodsDetails
                                  .largeAmountUpi.upiName
                              : paymentConfigModel.data.availableMethodsDetails
                                  .smallAmountUpi.upiName;
                          String upiType = enteredAmount > upiLimitAmount
                              ? paymentConfigModel.data.availableMethodsDetails
                                  .largeAmountUpi.type
                              : paymentConfigModel.data.availableMethodsDetails
                                  .smallAmountUpi.type;
                          String remark = enteredAmount > upiLimitAmount
                              ? paymentConfigModel.data.availableMethodsDetails
                                  .largeAmountUpi.remark
                              : paymentConfigModel.data.availableMethodsDetails
                                  .smallAmountUpi.remark;
                          await UpiPaymentFunction.upiPaymentFunction(
                            upiId: upiId,
                            upiName: upiName,
                            type: upiType,
                            remark: remark,
                            receiverName: userStatusModel.data.upiName,
                            receiverUpiId: userStatusModel.data.upiPaymentId,
                            app: app,
                            amount: enteredAmount,
                            context: context,
                            method: AddFundPaymentMethodList
                                .upiPaymentMethodList[selectedIndex]["method"],
                          );
                        } catch (e) {
                          // print("error$e");
                          SnackBarMessage.centeredSnackbar(
                            text: "Error try again",
                            context: context,
                          );
                        }
                        context.read<AppLoadingCubit>().updateAppLoadingState(
                              AppLoadingStates.initialLoading,
                            );
                      } else {
                        return SnackBarMessage.centeredSnackbar(
                          text: "Please Select Payment Method",
                          context: context,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            width: double.maxFinite,
            decoration: const BoxDecoration(color: kBlackColor),
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: VideoContainer(
              videoUrl:
                  paymentConfigModel.data.availableMethodsDetails.upi.video,
            ),
          ),
        ],
      );
    });
  }
}
