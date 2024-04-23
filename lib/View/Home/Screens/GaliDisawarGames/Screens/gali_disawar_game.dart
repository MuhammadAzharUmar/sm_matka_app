import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/History/Screens/check_history_details.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/ViewModel/galidesawar_game_list.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Widgets/convert_case_tile_function.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Widgets/starline_chart_container_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:vibration/vibration.dart';

import '../../../../../Utilities/colors.dart';
import '../../main_game_screen.dart';

class GaliDisawarGame extends StatefulWidget {
  const GaliDisawarGame({super.key});

  @override
  State<GaliDisawarGame> createState() => _GaliDisawarGameState();
}

class _GaliDisawarGameState extends State<GaliDisawarGame> {
  AsyncSnapshot<Map<String, dynamic>>? fetchedSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: kWhiteColor,
            )),
        backgroundColor: kBlue1Color,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Galidesawar Game",
          style: kMediumTextStyle.copyWith(
              color: kWhiteColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<UserCubit, UserModel>(
        builder: (context, user) {
          return FutureBuilder<Map<String, dynamic>>(
              future: HttpRequests.galiDisawarGameRequest(
                  context: context, token: user.token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Stack(
                      children: [
                        fetchedSnapshot != null
                            ? GaliDesawarMainWidget(snapshot: fetchedSnapshot!)
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
                    child: RefreshIndicator(
                      color: kBlue1Color,
                      backgroundColor: kWhiteColor,
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2))
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 100,
                                width: 100,
                                child: Text(
                                  "Try again",
                                  style: kMediumCaptionTextStyle.copyWith(
                                      color: kBlue1Color,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  fetchedSnapshot = snapshot;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: RefreshIndicator(
                        color: kBlue1Color,
                        backgroundColor: kWhiteColor,
                        onRefresh: () async {
                          await Future.delayed(const Duration(seconds: 2))
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: GaliDesawarMainWidget(
                          snapshot: fetchedSnapshot!,
                        )),
                  );
                }
              });
        },
      ),
    );
  }
}

class GaliDesawarMainWidget extends StatelessWidget {
  const GaliDesawarMainWidget({super.key, required this.snapshot});
  final AsyncSnapshot<Map<String, dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          StarlineGameChartLink(
            title: "Game Rates",
            subtitle: "Galidesawar Chart",
            chartUrl: snapshot.data!["data"]["gali_disawar_chart"],
          ),
          const SizedBox(
            height: 10,
          ),
          //game rates
          Card(
            elevation: 2,
            shape:
                const RoundedRectangleBorder(borderRadius: kMediumBorderRadius),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  color: kWhiteColor, borderRadius: kMediumBorderRadius),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!["data"]["gali_disawar_rates"].length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ConvertToTitleCase.convertToTitleCase(
                                snapshot.data!["data"]["gali_disawar_rates"]
                                    [index]["name"]),
                            style: kSmallTextStyle.copyWith(
                              color: kBlue3Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cost Amount",
                                style: kSmallCaptionTextStyle.copyWith(
                                  color: kBlue1Color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(snapshot.data!["data"]["gali_disawar_rates"]
                                  [index]["cost_amount"]),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Earning Amount",
                                style: kSmallCaptionTextStyle.copyWith(
                                  color: kBlue1Color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(snapshot.data!["data"]["gali_disawar_rates"]
                                  [index]["earning_amount"]),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        color: kBlue1Color,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          //bid and win history button
          Container(
            height: 56,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                    child: KLoginButton(
                  title: "Bid History",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckHistoryDetails(
                          title: "GaliDisawar Bid",
                          fetchData: (
                              {required context,
                              required startDate,
                              required toDate,
                              required token}) async {
                            return await HttpRequests
                                .galiDisawarBidHistoryRequest(
                                    context: context,
                                    token: token,
                                    fromDate: startDate,
                                    toDate: toDate);
                          },
                        ),
                      ),
                    );
                  },
                  gradient: kblueGradient,
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: KLoginButton(
                  title: "Win History",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckHistoryDetails(
                          title: "GaliDisawar Win",
                          fetchData: (
                              {required context,
                              required startDate,
                              required toDate,
                              required token}) async {
                            return await HttpRequests
                                .galiDisawarWinHistoryRequest(
                                    context: context,
                                    token: token,
                                    fromDate: startDate,
                                    toDate: toDate);
                          },
                        ),
                      ),
                    );
                  },
                  gradient: kblueGradient,
                )),
              ],
            ),
          ),

          // Text(snapshot.data!.toString()),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!["data"]["gali_disawar_game"].length,
            itemBuilder: (context, index) {
              bool isMarketOpen =
                  (snapshot.data!["data"]["gali_disawar_game"][index]["play"]);
              return InkWell(
                onTap: () {
                  if (isMarketOpen) {
                    //move to next page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MainGameScreen(
                          gameList: GaliDesawarGameList.galiDesawarGameList,
                          title: snapshot.data!["data"]["gali_disawar_game"]
                              [index]["name"],
                          data: snapshot.data!["data"]["gali_disawar_game"]
                              [index],
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
                  shape: const RoundedRectangleBorder(
                      borderRadius: kSmallBorderRadius),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    // height: 100,
                    decoration: const BoxDecoration(
                        borderRadius: kSmallBorderRadius, color: kWhiteColor),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!["data"]["gali_disawar_game"]
                                    [index]["name"],
                                style: kSmallTextStyle.copyWith(
                                  color: kBlue1Color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                snapshot.data!["data"]["gali_disawar_game"]
                                    [index]["result"],
                                style: kSmallTextStyle.copyWith(
                                  color: kBlue1Color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                snapshot.data!["data"]["gali_disawar_game"]
                                    [index]["time"],
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
                                    color:
                                        isMarketOpen ? kBlue1Color : Colors.red,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: kWhiteColor,
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
          ),
        ],
      ),
    );
  }
}
