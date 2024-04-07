import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class AddFundMethodWidget extends StatelessWidget {
  const AddFundMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.onPressed,
    required this.title,
    required this.url,
    required this.index,
  });

  final int selectedMethod;
  final int index;
  final Function(int) onPressed;
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          dense: true,
          isThreeLine: false,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          onTap: () {
            onPressed(index);
          },
          minVerticalPadding: 20,
          leading: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(
                  color: kBlue1Color,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(30)),
            child: Image.asset(
              url,
              width: 24,
              height: 24,
            ),
          ),
          title: Text(
            title,
            style: kMediumCaptionTextStyle.copyWith(
                color: kBlue1Color, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Auto approve",
            style: kSmallCaptionTextStyle.copyWith(
                color: kBlue1Color, fontWeight: FontWeight.w500),
          ),
          trailing: selectedMethod == index
              ? Image.asset(
                  "assets/General/check.png",
                  width: 18,
                  height: 18,
                )
              : null,
        ),
        const Divider(
          height: 1,
          thickness: .5,
          color: kBlue1Color,
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
