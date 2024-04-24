import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Screens/game_chart_screen.dart';
import 'package:sm_matka/View/Home/Screens/main_game_screen.dart';
import 'package:sm_matka/View/Home/Widgets/main_game_list.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:vibration/vibration.dart';

class MainGameListWidget extends StatefulWidget {
  const MainGameListWidget({
    super.key,
    required this.tryAgainFunction,
  });
  final VoidCallback tryAgainFunction;
  @override
  State<MainGameListWidget> createState() => _MainGameListWidgetState();
}

class _MainGameListWidgetState extends State<MainGameListWidget> {
  AsyncSnapshot<Map<String, dynamic>>? fetchedSnapshot;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2)).then((value) {
          setState(() {});
        });
      },
      child: BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
        
        return  FutureBuilder<Map<String, dynamic>>(
            future: HttpRequests.mainGameListRequest(
                context: context, token: user.token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Stack(
                    children: [
                      fetchedSnapshot != null
                          ? MainGameListviewBuilder(
                              snapshot: fetchedSnapshot!,
                            )
                          : Container(),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          child: const CircularProgressIndicator(
                            color: kBlue1Color,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      widget.tryAgainFunction();
                      setState(() {});
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                        child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Try again",
                                  style: kMediumCaptionTextStyle.copyWith(
                                      color: kBlue1Color,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Icon(Icons.refresh,size: 24,color: kBlue1Color,)
                              ],
                            ),),
                  ),
                );
              } else {
                fetchedSnapshot = snapshot;
                return fetchedSnapshot != null
                    ? MainGameListviewBuilder(
                        snapshot: fetchedSnapshot!,
                      )
                    : Container();
              }
            });
      }),
    );
  }
}

class MainGameListviewBuilder extends StatelessWidget {
  const MainGameListviewBuilder({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<Map<String, dynamic>> snapshot;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!["data"].length,
      itemBuilder: (context, index) {
        bool isMarketOpen = (snapshot.data!["data"][index]["market_open"] &&
            snapshot.data!["data"][index]["play"]);
        return InkWell(
          onTap: () {
            if (isMarketOpen) {
              //move to next page
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MainGameScreen(
                    gameList: MainGameList.mainGameList,
                    title: snapshot.data!["data"][index]["name"],
                    data: snapshot.data!["data"][index],
                  ),
                ),
              );
            } else {
              SnackBarMessage.centeredSnackbar(
                  text: "Market Closed", context: context);
              Vibration.vibrate(duration: 1000);
            }
          },
          child: Card(
            elevation: 2,
            shape:
                const RoundedRectangleBorder(borderRadius: kSmallBorderRadius),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // height: 100,
              decoration: const BoxDecoration(
                  borderRadius: kSmallBorderRadius, color: kWhiteColor),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GameChartScreen(
                            title: snapshot.data!["data"][index]["name"],
                            chatUrl: snapshot.data!["data"][index]["chart_url"],
                          ),
                        ),
                      );
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
                              color: isMarketOpen ? kBlue1Color : Colors.red,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.play_arrow,
                            color: kWhiteColor,
                          ),
                        ),
                        Text(
                          isMarketOpen ? "Running" : "Closed",
                          style: kSmallCaptionTextStyle.copyWith(
                              color: isMarketOpen ? kBlue1Color : Colors.red),
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
}
