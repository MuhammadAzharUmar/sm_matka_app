// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Screens/gali_disawar_game_btm_sheet.dart';
import 'package:sm_matka/View/Home/Widgets/crousel_slider.dart';
import 'package:sm_matka/View/Home/Widgets/fund_withdraw_chat_call_button_widget.dart';
import 'package:sm_matka/View/Home/Widgets/home_appbar_widget.dart';
import 'package:sm_matka/View/Home/Widgets/main_gamelist_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserModel user = UserModel.fromJson(json: {}, token: "");
  UserStatusModel userStatus = UserStatusModel.fromJson({});
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      user = context.read<UserCubit>().state;
      if (user.token=="") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("userToken") ?? "";
      if (token != "") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String token = preferences.getString("userToken") ?? "";
        final data = await HttpRequests.getUserDetailsRequest(
          context: context,
          token: token,
        );
        UserModel user = UserModel.fromJson(json: data, token: token);
        BlocProvider.of<UserCubit>(context).updateAppUser(user);
        final statusdata = await HttpRequests.getUserStatusRequest(
          context: context,
          token: token,
        );
        UserStatusModel userStatus = UserStatusModel.fromJson(statusdata);
        BlocProvider.of<UserStatusCubit>(context)
            .updateAppUserStatus(userStatus);
      }
      }
      userStatus = context.read<UserStatusCubit>().state;
      await HttpRequests.mainGameListRequest(context: context, token: user.token);

    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.maxFinite, 56),
        child: HomeAppBarWidget(),
      ),
      body: FutureBuilder(
          future: HttpRequests.appDetialsRequest(context: context),
          builder: (context, appDetailsModel) {
            if (appDetailsModel.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  child: const CircularProgressIndicator(
                    color: kBlue1Color,
                    strokeWidth: 3,
                  ),
                ),
              );
            } else if (appDetailsModel.hasError) {
              return Center(
                child: InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 100,
                      child: Text(
                        "Try again",
                        style: kMediumCaptionTextStyle.copyWith(
                            color: kBlue1Color, fontWeight: FontWeight.w600),
                      )),
                ),
              );
            } else {
              // update appdetails in cubit
              BlocProvider.of<AppDetailsCubit>(context)
                  .updateAppDetails(appDetailsModel.data!);

                  List<String> crouselImageList=[
                      appDetailsModel.data!.data.bannerImage.bannerImg1,
                      appDetailsModel.data!.data.bannerImage.bannerImg2,
                      appDetailsModel.data!.data.bannerImage.bannerImg3,
                    ];
                    crouselImageList.removeWhere((element) => element=="");
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSliderWidget(
                    crouselImages: crouselImageList,
                    marqueeText: appDetailsModel.data!.data.bannerMarquee,
                  ),
                  FundWithdrawChatCallButtonWidget(
                    contactDetails: appDetailsModel.data!.data.contactDetails,
                  ),
                  InkWell(
                    onTap: () {
                      GaliDisawarGameBtmSheet.galiDisawarGameBtmSheet(context: context);
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.only(left: 40, right: 15),
                      height: 46,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                          gradient: kblueGradient,),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "GALI DISAWAR GAME",
                            style: kSmallTextStyle.copyWith(
                              color: kWhiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                          const Icon(
                            Icons.arrow_circle_right,
                            color: kWhiteColor,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Expanded(
                      child: MainGameListWidget())
                ],
              );
            }
          }),
    );
  }
}
