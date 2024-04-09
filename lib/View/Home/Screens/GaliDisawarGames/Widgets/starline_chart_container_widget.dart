
import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Screens/game_chart_screen.dart';

class StarlineGameChartLink extends StatelessWidget {
  const StarlineGameChartLink({
    super.key,
    required this.title,
    required this.subtitle,
    required this.chartUrl,
  });
  final String title;
  final String subtitle;
  final String chartUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:5, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration:  BoxDecoration(
        border: Border.all(color: k2ndColor,width: 2),
          gradient: kblueGradient, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kMediumTextStyle.copyWith(
              color: kWhiteColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameChartScreen(
                    title: subtitle,
                    chatUrl: chartUrl,
                  ),
                ),
              );
            },
            child: Text(
              subtitle,
              style: kMediumCaptionTextStyle.copyWith(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                  decorationThickness: 3,
                  decorationColor: kWhiteColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
