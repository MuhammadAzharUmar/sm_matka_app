// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Models/payment_config_model.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Screens/AddFundScreens/add_fund_method_page.dart';
import 'package:sm_matka/View/Funds/Widgets/AddFundWidget/add_fund_payment_method_list.dart';
import 'package:sm_matka/View/Funds/Widgets/add_enterpoints_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/fund_appbar_widget.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';
import 'package:sm_matka/ViewModel/BlocCubits/add_fund_method_active_index_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/payment_config_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class AddFundPage extends StatefulWidget {
  const AddFundPage({super.key});

  @override
  State<AddFundPage> createState() => _AddFundPageState();
}

class _AddFundPageState extends State<AddFundPage> {
  TextEditingController pointsController = TextEditingController();
  List<String> addPointsButton = [
    "500",
    "1000",
    "2000",
    "5000",
  ];
  List<Map<String, dynamic>> listOfPaymentGatewayAndScreen() {
    PaymentConfigModel paymentConfigModel =
        context.read<PaymentConfigCubit>().state;

//let set the default method for first active index based on method
    String defaultMethod =
        paymentConfigModel.data.availableMethodsDetails.defaultMethod;
    final mapOfMethodAndTitle = {
      "upi": "UPI",
      "qrcode": "SCAN",
      "bank_account": "BANK",
      "pay_sants": "PAYSANTS",
      "indicpay": "INDICPAY"
    };

    ///
    //   pay_sants
    //   indicpay

    List<Map<String, dynamic>> listOfPaymentScreen = [];

    if (paymentConfigModel.data.availableMethods.upi) {
      listOfPaymentScreen
          .add(AddFundPaymentMethodList.addFundPaymentMethodList[0]);
    }
    if (paymentConfigModel.data.availableMethods.qrCode) {
      listOfPaymentScreen
          .add(AddFundPaymentMethodList.addFundPaymentMethodList[1]);
    }
    if (paymentConfigModel.data.availableMethods.bankAccount) {
      listOfPaymentScreen
          .add(AddFundPaymentMethodList.addFundPaymentMethodList[2]);
    }
    if (paymentConfigModel.data.availableMethods.paymentGateway.length == 1) {
      if (paymentConfigModel.data.availableMethods.paymentGateway[0].type ==
          "pay_sants") {
        listOfPaymentScreen
            .add(AddFundPaymentMethodList.addFundPaymentMethodList[3]);
      } else {
        listOfPaymentScreen
            .add(AddFundPaymentMethodList.addFundPaymentMethodList[4]);
      }
    } else if (paymentConfigModel.data.availableMethods.paymentGateway.length ==
        2) {
      if (paymentConfigModel.data.availableMethods.paymentGateway[0].type ==
          "pay_sants") {
        listOfPaymentScreen
            .add(AddFundPaymentMethodList.addFundPaymentMethodList[3]);
      } else {
        listOfPaymentScreen
            .add(AddFundPaymentMethodList.addFundPaymentMethodList[4]);
      }
      //
      if (paymentConfigModel.data.availableMethods.paymentGateway[1].type ==
          "pay_sants") {
        listOfPaymentScreen
            .add(AddFundPaymentMethodList.addFundPaymentMethodList[3]);
      } else {
        listOfPaymentScreen
            .add(AddFundPaymentMethodList.addFundPaymentMethodList[4]);
      }
    }
    //set the current Index
    int defaultIndex = listOfPaymentScreen.indexWhere(
      (element) => element["title"] == mapOfMethodAndTitle[defaultMethod],
    );
    if (defaultIndex != -1) {
      context
          .read<ActiveFundMethodActiveIndexCubit>()
          .updateIndex(defaultIndex);
    }
    return listOfPaymentScreen;
  }

  int selectedMethod = -1;
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
                    title: "Add Points",
                    points: userStatus.data.availablePoints,
                  ),
                ),
                body: Container(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AddFundNoticeWidget(
                          heading: "Add Fund Notice",
                          addfundNotice: appdetailsModel.data.addFundNotice,
                        ),
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
                              Text(
                                "Select Points",
                                style: kMediumCaptionTextStyle.copyWith(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AddEnterPointsWidget(
                                  addPointsButton: addPointsButton,
                                  pointsController: pointsController)
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
                                  loadingstate: AppLoadingStates
                                      .paymentConfigSubmitLoading,
                                  onPressed: () async {
                                    if (pointsController.text.trim() != "") {
                                      context
                                          .read<AppLoadingCubit>()
                                          .updateAppLoadingState(
                                              AppLoadingStates
                                                  .paymentConfigSubmitLoading);

                                      try {
                                        final jsonData = await HttpRequests
                                            .paymentConfigRequest(
                                          context: context,
                                          token: user.token,
                                        );
                                        context
                                            .read<PaymentConfigCubit>()
                                            .updateAppDetails(
                                              PaymentConfigModel.fromJson(
                                                jsonData,
                                              ),
                                            );
                                        PaymentConfigModel paymentConfigModel =
                                            context
                                                .read<PaymentConfigCubit>()
                                                .state;
                                        List<Map<String, dynamic>>
                                            paymentGatewayAndScreenList =
                                            listOfPaymentGatewayAndScreen();

                                        if (paymentGatewayAndScreenList
                                            .isEmpty) {
                                          //redirect to whatsapp
                                          await LaunchCustomUrls.launchURL(
                                            url:
                                                "https://wa.me/${paymentConfigModel.data.supportNumber}",
                                          );
                                        } else {
                                          if (paymentConfigModel.data.availableMethodsDetails.amountConfiguration!="1") {
                                            return SnackBarMessage.centeredSnackbar(text: "Service unavailable", context: context,);
                                          } else {
                                          
                                          
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddFundMethodPage(
                                                availablePaymentGatewayMethodList:
                                                    paymentGatewayAndScreenList,
                                                points: pointsController.text
                                                    .trim(),
                                              ),
                                            ),
                                          );}
                                        }
                                      } catch (e) {
                                        SnackBarMessage.centeredSnackbar(
                                          text: "Unknown Error ",
                                          context: context,
                                        );
                                      }
                                      context
                                          .read<AppLoadingCubit>()
                                          .updateAppLoadingState(
                                              AppLoadingStates.initialLoading);
                                    } else {
                                      SnackBarMessage.centeredSnackbar(
                                        text: "Please Select Points",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.security,
                              color: kBlue1Color,
                              size: 16,
                            ),
                            Text(
                              "100 % Secure",
                              style: kMediumCaptionTextStyle.copyWith(
                                  color: kBlue1Color),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
