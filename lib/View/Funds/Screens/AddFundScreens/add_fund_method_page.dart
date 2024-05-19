import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Funds/Screens/AddFundScreens/bank_pay.dart';
import 'package:sm_matka/View/Funds/Screens/AddFundScreens/indicpay.dart';
import 'package:sm_matka/View/Funds/Screens/AddFundScreens/paysants.dart';
import 'package:sm_matka/View/Funds/Screens/AddFundScreens/scan_pay.dart';
import 'package:sm_matka/View/Funds/Screens/AddFundScreens/upi_payment_page.dart';
import 'package:sm_matka/View/Funds/Widgets/AddFundWidget/add_fund_payment_method_list.dart';
import 'package:sm_matka/View/Funds/Widgets/AddFundWidget/fund_payment_option_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/add_fund_method_active_index_cubit.dart';

class AddFundMethodPage extends StatefulWidget {
  const AddFundMethodPage(
      {super.key,
      required this.points,
      required this.availablePaymentGatewayMethodList});
  final String points;
  final List<Map<String, dynamic>> availablePaymentGatewayMethodList;
  @override
  State<AddFundMethodPage> createState() => _AddFundMethodPageState();
}

class _AddFundMethodPageState extends State<AddFundMethodPage> {
  Widget giveTitleAndPointsGetWidget({
    required String points,
    required String title,
  }) {
    if (title == "UPI") {
      return AddFundPaymentMethodList.titleWidgetMappingMap[title](
        UpiPaymentScreen(
          points: points,
        ),
      );
    } else if (title == "SCAN") {
      return AddFundPaymentMethodList.titleWidgetMappingMap[title](
        ScanPayScreen(
          points: points,
        ),
      );
    } else if (title == "BANK") {
      return AddFundPaymentMethodList.titleWidgetMappingMap[title](
        BankPayScreen(
          points: points,
        ),
      );
    } else if (title == "PAY_SANTS") {
      return AddFundPaymentMethodList.titleWidgetMappingMap[title](
        PaysantsScreenWidget(
          points: points,
          caller: "pay_sants",
        ),
      );
    } else {
      // INDICPAY
      return AddFundPaymentMethodList.titleWidgetMappingMap[title](
        IndicPayScreenWidget(
          caller: "indicpay",
          points: widget.points,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          "Add Fund Method",
          style: kMediumTextStyle.copyWith(
              color: kWhiteColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<ActiveFundMethodActiveIndexCubit, int>(
          builder: (context, activeIndex) {
        return Container(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: Column(
            children: [
              FundPaymentOptionWidget(
                availablePaymentGatewayList:
                    widget.availablePaymentGatewayMethodList,
              ),
              const Divider(
                height: 24,
                color: kBlue1Color,
                indent: 24,
                endIndent: 24,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                      child: giveTitleAndPointsGetWidget(
                    points: widget.points,
                    title: widget.availablePaymentGatewayMethodList[activeIndex]
                        ["title"],
                  )),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
