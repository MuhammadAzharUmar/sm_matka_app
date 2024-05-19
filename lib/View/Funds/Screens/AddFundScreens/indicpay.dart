// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/indicpay_payment_request_model.dart';
import 'package:sm_matka/Models/payment_config_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/AddFundWidget/ad_video_player.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/payment_config_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class IndicPayScreenWidget extends StatefulWidget {
  const IndicPayScreenWidget({
    super.key,
    required this.caller,
    required this.points,
  });
  final String caller;
  final String points;
  @override
  State<IndicPayScreenWidget> createState() => _IndicPayScreenWidgetState();
}

class _IndicPayScreenWidgetState extends State<IndicPayScreenWidget> {
  TextEditingController transctionIdController = TextEditingController();
  String video = "";
  String notice = "";

  getTheVideoAndNotice() {
    video = "";
    notice = "";
    PaymentConfigModel paymentConfigModel =
        context.read<PaymentConfigCubit>().state;
    //first know who is the caller

    if (paymentConfigModel.data.availableMethods.paymentGateway.length == 1) {
      if (paymentConfigModel.data.availableMethods.paymentGateway[0].type ==
          widget.caller) {
        video =
            paymentConfigModel.data.availableMethods.paymentGateway[0].video;
        notice =
            paymentConfigModel.data.availableMethods.paymentGateway[0].notice;
      }
    } else if (paymentConfigModel.data.availableMethods.paymentGateway.length ==
        2) {
      if (paymentConfigModel.data.availableMethods.paymentGateway[0].type ==
          widget.caller) {
        video =
            paymentConfigModel.data.availableMethods.paymentGateway[0].video;
        notice =
            paymentConfigModel.data.availableMethods.paymentGateway[0].notice;
      } else if (paymentConfigModel
              .data.availableMethods.paymentGateway[1].type ==
          widget.caller) {
        video =
            paymentConfigModel.data.availableMethods.paymentGateway[1].video;
        notice =
            paymentConfigModel.data.availableMethods.paymentGateway[1].notice;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getTheVideoAndNotice();
    return BlocBuilder<UserCubit, UserModel>(builder: (context, currentUser) {
      return BlocBuilder<PaymentConfigCubit, PaymentConfigModel>(
          builder: (context, paymentConfigModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AddFundNoticeWidget(
                heading: "Notice",
                addfundNotice: notice,
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
                        widget.points,
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
                        if (widget.points == "") {
                          return SnackBarMessage.centeredSnackbar(
                            text: "Please select amount",
                            context: context,
                          );
                        }
                        context.read<AppLoadingCubit>().updateAppLoadingState(
                            AppLoadingStates.paymentSubmitButtonLoading);
                        try {
                          final json =
                              await HttpRequests.indicpayPayemntRequest(
                            context: context,
                            token: currentUser.token,
                            amount: widget.points,
                            authorization: "",
                          );
                          // print(json);
                          IndicpayPaymentRequestModel
                              indicpayPaymentRequestModel =
                              IndicpayPaymentRequestModel.fromJson(json);
                          // print(indicpayPaymentRequestModel.data.upiUrl);
                          if (indicpayPaymentRequestModel.data.txnid != "") {
                            await LaunchCustomUrls.launchURL(
                                url: indicpayPaymentRequestModel.data.upiUrl);
                            await HttpRequests.payemntReceiveRequest(
                              context: context,
                              token: currentUser.token,
                              amount: widget.points,
                              authorization: "",
                              status: indicpayPaymentRequestModel.data.status,
                              method: 'indicpay',
                              transcationId:
                                  indicpayPaymentRequestModel.data.txnid,
                              methodDetails: '',
                              screenshot: '',
                            );
                          } else {
                            return SnackBarMessage.centeredSnackbar(
                              text: "failed try again later",
                              context: context,
                            );
                          }
                        } catch (e) {
                          SnackBarMessage.centeredSnackbar(
                            text: "could not launch payment method",
                            context: context,
                          );
                        }
                        context.read<AppLoadingCubit>().updateAppLoadingState(
                            AppLoadingStates.initialLoading);
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
                videoUrl: video,
              ),
            ),
          ],
        );
      });
    });
  }
}
