import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Screens/game_chat_screen.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:vibration/vibration.dart';

class MainGameListWidget extends StatefulWidget {
  const MainGameListWidget({
    super.key,
  });

  @override
  State<MainGameListWidget> createState() => _MainGameListWidgetState();
}

class _MainGameListWidgetState extends State<MainGameListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
      return FutureBuilder<Map<String, dynamic>>(
          future: HttpRequests.mainGameListRequest(
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
                            color: kBlue1Color, fontWeight: FontWeight.w600),
                      )),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!["data"].length,
                itemBuilder: (context, index) {
                  bool isMarketOpen = (snapshot.data!["data"][index]
                          ["market_open"] &&
                      snapshot.data!["data"][index]["play"]);
                  return InkWell(
                    onTap: () {
                      if (isMarketOpen) {
                        //move to next page
                      } else {
                        print("object");
                        SnackBarMessage.centeredSnackbar(text: "Market Closed", context: context);
                        Vibration.vibrate(duration: 1000);
                      }
                    },
                    child: Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                          borderRadius: kSmallBorderRadius),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        // height: 100,
                        decoration: const BoxDecoration(
                            borderRadius: kSmallBorderRadius,
                            color: kblue1color),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameChartScreen(title: snapshot.data!["data"][index]["name"], chatUrl: snapshot.data!["data"][index]["chart_url"],),),);
                              },
                              child: Container(
                                height: 56,
                                width: 56,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/General/graph.png",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!["data"][index]["name"],
                                    style: kSmallTextStyle.copyWith(
                                      color: kBlue1Color,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!["data"][index]["result"],
                                    style: kSmallTextStyle.copyWith(
                                      color: kBlue1Color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Open: ${snapshot.data!["data"][index]["open_time"]} \t\t|\t\t Close:${snapshot.data!["data"][index]["close_time"]}",
                                    style: kSmallCaptionTextStyle.copyWith(
                                        color: kBlue1Color),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 56,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        color: isMarketOpen
                                            ? kBlue1Color
                                            : Colors.red,
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.play_arrow,
                                      color: kblue1color,
                                    ),
                                  ),
                                  Text(
                                    isMarketOpen ? "Running" : "Closed",
                                    style: kSmallCaptionTextStyle.copyWith(
                                        color: isMarketOpen
                                            ? kBlue1Color
                                            : Colors.red),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          });
    });
  }
}
