import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/ViewModel/BlocCubits/add_fund_method_active_index_cubit.dart';

class FundPaymentOptionWidget extends StatelessWidget {
  const FundPaymentOptionWidget({
    super.key, required this.availablePaymentGatewayList,
  });
final List<Map<String,dynamic>> availablePaymentGatewayList;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      decoration: const BoxDecoration(
          // gradient: klightGreyGradient,
          ),
      alignment: Alignment.center,
      child: BlocBuilder<ActiveFundMethodActiveIndexCubit,int>(
        builder: (context,activeIndex) {
          return ListView.builder(
            itemCount:
                availablePaymentGatewayList.length,
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(
                left: index == 0 ? 16 : 0,
                right: index ==
                        availablePaymentGatewayList.length -
                            1
                    ? 16
                    : 12),
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    borderRadius: kSmallBorderRadius),
                child: InkWell(
                  onTap: () {
                context
                    .read<ActiveFundMethodActiveIndexCubit>()
                    .updateIndex(index);
              },
                  child: Ink(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      // color:index==0?k2ndColor: kWhiteColor,
                      gradient: index == activeIndex
                          ? klightGreyGradient
                          : kWhiteGreyGradient,
                      borderRadius: kSmallBorderRadius,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
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
                                  availablePaymentGatewayList[index]
                                      ["img"],
                                  width: 36,
                                  height: 36,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          availablePaymentGatewayList[index]["title"],
                          style: kMediumCaptionTextStyle.copyWith(
                            color: kBlue1Color,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
