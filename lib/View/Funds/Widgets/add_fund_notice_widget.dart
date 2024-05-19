
import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class AddFundNoticeWidget extends StatelessWidget {
  const AddFundNoticeWidget({
    super.key, required this.addfundNotice, required this.heading,
  });
final String addfundNotice;
final String heading;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
          borderRadius: kMediumBorderRadius),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
            gradient: klightGreyGradient,
            borderRadius: kMediumBorderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
             heading,
              style: kMediumTextStyle.copyWith(
                color: kBlue1Color,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                addfundNotice,
                textAlign: TextAlign.left,
                style: kMediumCaptionTextStyle.copyWith(
                  color: kBlue3Color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
