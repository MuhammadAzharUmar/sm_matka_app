import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class SnackBarMessage {
  static simpleSnackBar({required String text, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: kMediumTextStyle.copyWith(color: kWhiteColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static centeredSnackbar(
      {required String text, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
        content: Center(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                borderRadius: kSmallBorderRadius, color: Colors.red),
            // width: 100,
            height: 40,

            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
