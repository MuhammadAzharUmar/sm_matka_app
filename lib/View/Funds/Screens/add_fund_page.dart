import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/add_enterpoints_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
import 'package:sm_matka/View/Funds/Widgets/addfund_method_index.dart';
import 'package:sm_matka/View/Funds/Widgets/fund_appbar_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';

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
  int selectedMethod = -1;
  @override
  Widget build(BuildContext context) {
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
                      Card(
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius: kMediumBorderRadius),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: kMediumBorderRadius),
                          child: Column(
                            children: [
                              AddFundMethodWidget(
                                index: 1,
                                selectedMethod: selectedMethod,
                                url: "assets/Fund/gpay.png",
                                title: "Google Pay",
                                onPressed: (newMethodIndex) {
                                  setState(() {
                                    selectedMethod = newMethodIndex;
                                  });
                                },
                              ),
                              AddFundMethodWidget(
                                index: 2,
                                selectedMethod: selectedMethod,
                                url: "assets/Fund/phonepe.png",
                                title: "Phone Pay",
                                onPressed: (newMethodIndex) {
                                  setState(() {
                                    selectedMethod = newMethodIndex;
                                  });
                                },
                              ),
                              AddFundMethodWidget(
                                index: 3,
                                selectedMethod: selectedMethod,
                                url: "assets/Fund/paytm.png",
                                title: "Paytm",
                                onPressed: (newMethodIndex) {
                                  setState(() {
                                    selectedMethod = newMethodIndex;
                                  });
                                },
                              ),
                            ],
                          ),
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
                                title: "continue",
                                onPressed: () async {
                                  if (kDebugMode) {
                                    print("Adding Fund");
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
  }
}
