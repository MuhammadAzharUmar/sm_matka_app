import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Widgets/home_init_function.dart';
import 'package:sm_matka/View/Home/Screens/notification_screen.dart';
import 'package:sm_matka/View/Home/Screens/wallet_screen.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStatusCubit, UserStatusModel>(
        builder: (context, userStatus) {
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
            onPressed: () async{
              
              bool poped=await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
              if (poped) {
                // ignore: use_build_context_synchronously
                await HomeInitFunction.refreshAppDetailsFunction(context: context);
              }
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              size: 20,
              color: kWhiteColor,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WalletScreen(),
                ),
              );
            },
            child: Text(
              userStatus.data.availablePoints,
              style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WalletScreen(),
                ),
              );
            },
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
    });
  }
}
