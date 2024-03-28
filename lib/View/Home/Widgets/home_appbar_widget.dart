
import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBlue1Color,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Center(
        child: Container(
          height: 32,
          width: 32,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: kblueGradient,
              image:
                  DecorationImage(image: AssetImage("assets/Logo/logo.png"))),
        ),
      ),
      title: Text(
        "SM MATKA",
        style: kMediumTextStyle.copyWith(
            color: kWhiteColor, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_active_outlined,
            size: 20,
            color: kWhiteColor,
          ),
        ),
        Text(
          "123456789",
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
                    image: AssetImage("assets/General/coins.png"))),
          ),
        ),
      ],
    );
  }
}
