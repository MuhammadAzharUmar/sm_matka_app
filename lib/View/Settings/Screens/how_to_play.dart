import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblue1color,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: kblue1color,
            )),
        backgroundColor: kBlue1Color,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "How To Play",
          style: kMediumTextStyle.copyWith(
              color: kblue1color, fontWeight: FontWeight.w700),
        ),
      ),
      body:  BlocBuilder<UserCubit, UserModel>(builder: (context, user) {return FutureBuilder(
                  future: HttpRequests.howToPlayRequest(
                      context: context, token: user.token),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                    } else if (snapshot.hasError) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              child: Text(
                                "Try again",
                                style: kMediumCaptionTextStyle.copyWith(
                                    color: kBlue1Color,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 20),
                            child: Card(
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
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/Logo/logo.png"))),
                                    ),
                                    Text(
                                      "SM MATKA",
                                      style: kLargeTextStyle.copyWith(
                                        color: kBlue3Color,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      "The Best Matka Game Play App",
                                      style: kSmallTextStyle.copyWith(
                                        color: kBlue3Color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.symmetric(vertical: 20),
                                      height: 32,
                                      alignment: Alignment.bottomCenter,
                                      // color: k2ndColor,
                                      child: Marquee(
                                        text:
                                            "Follow below steps to play the game               \t",
                                        style: kMediumCaptionTextStyle.copyWith(
                                            color: kBlue1Color),
                                        scrollAxis: Axis.horizontal,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data!["data"]["how_to_play"],
                                        style: kMediumTextStyle.copyWith(
                                          color: kBlue3Color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (snapshot.data!["data"]["video_link"] != "") {
                                  await LaunchCustomUrls.launchURL(
                                      url: snapshot.data!["data"]["video_link"]);
                                } else {
                                  SnackBarMessage.simpleSnackBar(
                                      text: "Comming soon", context: context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kblue1color,
                                elevation: 0,
                              ),
                              child: Image.asset(
                                "assets/General/youtube.png",
                                width: 100,
                                height: 46,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
        }
      ),
    );
  }
}
