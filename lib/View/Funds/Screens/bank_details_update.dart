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
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/fund_appbar_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class BankDetailsUpdateScreen extends StatefulWidget {
  const BankDetailsUpdateScreen({super.key});

  @override
  State<BankDetailsUpdateScreen> createState() =>
      _BankDetailsUpdateScreenState();
}

class _BankDetailsUpdateScreenState extends State<BankDetailsUpdateScreen> {
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNoContoller = TextEditingController();
  TextEditingController confirmAccountNoController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchAddressController = TextEditingController();
@override
  void initState() {
    super.initState();
    UserModel user= context.read<UserCubit>().state;
  accountHolderNameController.text =user.data.accountHolderName;
   accountNoContoller.text = user.data.bankAccountNo;
   confirmAccountNoController.text = user.data.bankAccountNo;
   ifscCodeController.text = user.data.ifscCode;
   bankNameController.text = user.data.bankName;
   branchAddressController.text = user.data.branchAddress;
  }
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
                title: "Bank Details",
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
                            keyboardType: TextInputType.name,

                            controller: accountHolderNameController,
                            labelText: "Account Holder Name",
                          ),
                          InputTextFieldWidget(
                            controller: accountNoContoller,
                            labelText: "Account Number",
                          ),
                          InputTextFieldWidget(
                            controller: confirmAccountNoController,
                            labelText: "Confirm Account Number",
                          ),
                          InputTextFieldWidget(
                            controller: ifscCodeController,
                            labelText: "IFSC code",
                          ),
                          InputTextFieldWidget(
                            controller: bankNameController,
                            labelText: "Bank Name",
                          ),
                          InputTextFieldWidget(
                            controller: branchAddressController,
                            labelText: "Branch Address",
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
                              loadingstate: AppLoadingStates.bankDetailSubmitButton,
                              onPressed: () async {
                                if (accountNoContoller.text.trim() !=
                                    confirmAccountNoController.text.trim()) {
                                  return SnackBarMessage.centeredSnackbar(
                                      text:
                                          "Account number confirmation does not match",
                                      context: context);
                                } else {
                                  BlocProvider.of<AppLoadingCubit>(
                                            context)
                                        .updateAppLoadingState(
                                            AppLoadingStates.bankDetailSubmitButton);
                                  final jsonData = await HttpRequests
                                      .updateBankDetailsRequest(
                                    context: context,
                                    token: user.token,
                                    accHolderName:
                                        accountHolderNameController.text.trim(),
                                    accNumber: accountNoContoller.text.trim(),
                                    ifscCode: ifscCodeController.text.trim(),
                                    bankName: bankNameController.text.trim(),
                                    branchAddress:
                                        branchAddressController.text.trim(),
                                  );
                                  if (jsonData.isEmpty) {
                                     BlocProvider.of<AppLoadingCubit>(
                                            context)
                                        .updateAppLoadingState(
                                            AppLoadingStates.initialLoading);
                                  }
                                  if (jsonData["code"] == "100" &&
                                      jsonData["status"] == "success") {
                                    final jsonNewUser = await HttpRequests
                                        .getUserDetailsRequest(
                                            context: context,
                                            token: user.token);
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
                                   BlocProvider.of<AppLoadingCubit>(
                                            context)
                                        .updateAppLoadingState(
                                            AppLoadingStates.initialLoading);
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
    });
  }
}
