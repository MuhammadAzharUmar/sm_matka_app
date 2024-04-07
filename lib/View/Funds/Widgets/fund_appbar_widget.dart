import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class FundAppBarWidget extends StatelessWidget {
  const FundAppBarWidget({
    super.key,
    required this.title,
    required this.points,
  });
  final String title;
  final String points;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBlue1Color,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Center(
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: kWhiteColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: kMediumTextStyle.copyWith(
            color: kWhiteColor, fontWeight: FontWeight.w700),
      ),
      actions: [
        Text(
          points,
          style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: kblueGradient,
              image: DecorationImage(
                image: AssetImage("assets/General/coins.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
