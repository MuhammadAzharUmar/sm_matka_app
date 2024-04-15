// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/fund_appbar_widget.dart';
import 'package:sm_matka/View/Home/Screens/Games/bid_tile_widget.dart';
import 'package:sm_matka/View/Home/Screens/Games/game_bid_model.dart';
import 'package:sm_matka/View/Home/Screens/Games/games_field_data_map.dart';
import 'package:sm_matka/View/Home/Screens/Games/input_suggestion_field_widget.dart';
import 'package:sm_matka/View/Home/Screens/Games/open_close_button.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class GamesFieldScreen extends StatefulWidget {
  const GamesFieldScreen(
      {super.key, required this.title, required this.marketDetails});
  final String title;
  final Map<String, dynamic> marketDetails;
  @override
  State<GamesFieldScreen> createState() => _GamesFieldScreenState();
}

class _GamesFieldScreenState extends State<GamesFieldScreen> {
  String formatDateTime(DateTime dateTime) {
    // Define abbreviated day names
    List<String> daysOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    // Define month names
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    // Extract day of week, day, month, and year
    String dayOfWeek = daysOfWeek[dateTime.weekday - 1];
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = months[dateTime.month - 1];
    String year = dateTime.year.toString();

    // Concatenate the formatted date
    return '$dayOfWeek-$day-$month-$year';
  }

  String convertToGameTypeFormat(String text) {
    // Split the text by space
    List<String> words = text.split(' ');

    // Convert each word to lowercase and join them with underscore
    return words.map((word) => word.toLowerCase()).join('_');
  }

  TextEditingController firstController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isOpenSelected = true;

  List<GameBid> gameBids = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
      return BlocBuilder<UserStatusCubit, UserStatusModel>(
          builder: (context, userStatus) {
        return Scaffold(
          backgroundColor: kWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size(double.maxFinite, 56),
            child: FundAppBarWidget(
              title: widget.title,
              points: (int.parse(userStatus.data.availablePoints) -
                      gameBids
                          .map((e) => int.parse(e.bidPoints))
                          .fold(0, (prev, curr) => prev + curr))
                  .toString(),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: kSmallBorderRadius),
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: const BoxDecoration(
                          gradient: kblueGradient,
                          borderRadius: kSmallBorderRadius),
                      child: Text(
                        formatDateTime(
                          DateTime.now(),
                        ),
                        style: kSmallTextStyle.copyWith(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: kSmallBorderRadius),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: const BoxDecoration(
                        gradient: kblueGradient,
                        borderRadius: kSmallBorderRadius,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (widget.title == "Jodi Digit" ||
                                  widget.title == "Full Sangam")
                              ? Container(
                                  height: 0,
                                )
                              : SizedBox(
                                  height: 56,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: KOpenCloseButton(
                                          isLeft: true,
                                          title: "Open",
                                          onPressed: () {
                                            setState(() {
                                              isOpenSelected = true;
                                            });
                                          },
                                          gradient: isOpenSelected
                                              ? klightGreyGradient
                                              : kblueGradient,
                                        ),
                                      ),
                                      Expanded(
                                        child: KOpenCloseButton(
                                          isLeft: false,
                                          title: "Close",
                                          onPressed: () {
                                            setState(() {
                                              isOpenSelected = false;
                                            });
                                          },
                                          gradient: isOpenSelected
                                              ? kblueGradient
                                              : klightGreyGradient,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          InputSuggestionTextFieldWidget(
                            keyboardType: TextInputType.number,
                            inputFormatter: GamesFieldsDataMap
                                    .gamesFieldsDataMap[widget.title]
                                ["inputFormater"],
                            controller: firstController,
                            suggestions: GamesFieldsDataMap
                                    .gamesFieldsDataMap[widget.title]
                                ["first_field_title_allowed"],
                            labelText: GamesFieldsDataMap
                                    .gamesFieldsDataMap[widget.title]
                                [(widget.title == "Half Sangam")
                                    ? isOpenSelected
                                        ? "first_field_title"
                                        : "first_field_title_close"
                                    : "first_field_title"],
                          ),
                          (widget.title == "Half Sangam" ||
                                  widget.title == "Full Sangam")
                              ? InputSuggestionTextFieldWidget(
                                  keyboardType: TextInputType.number,
                                  inputFormatter: GamesFieldsDataMap
                                          .gamesFieldsDataMap[widget.title]
                                      ["inputFormater"],
                                  suggestions: GamesFieldsDataMap
                                          .gamesFieldsDataMap[widget.title]
                                      ["first_field_title_allowed"],
                                  controller: thirdController,
                                  labelText: GamesFieldsDataMap
                                          .gamesFieldsDataMap[widget.title]
                                      [(widget.title == "Half Sangam")
                                          ? isOpenSelected
                                              ? "third_field_title"
                                              : "third_field_title_close"
                                          : "third_field_title"],
                                )
                              : Container(
                                  height: 1,
                                ),
                          InputTextFieldWidget(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            labelText: GamesFieldsDataMap
                                    .gamesFieldsDataMap[widget.title]
                                ["second_field_title"],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: KLoginButton(
                                    title: "Add Bid",
                                    onPressed: () async {
                                      if (GamesFieldsDataMap
                                              .gamesFieldsDataMap[widget.title]
                                                  ["first_field_title_allowed"]
                                              .contains(
                                            firstController.text.trim(),
                                          ) &&
                                          (widget.title != "Half Sangam" &&
                                                  widget.title !=
                                                      "Full Sangam" ||
                                              GamesFieldsDataMap
                                                  .gamesFieldsDataMap[
                                                      widget.title][
                                                      "first_field_title_allowed"]
                                                  .contains(
                                                thirdController.text.trim(),
                                              ))) {
                                        gameBids.add(
                                          GamesFieldsDataMap.getGameBid(
                                            first: firstController.text,
                                            second: thirdController.text,
                                            amount: amountController.text,
                                            isOpen: isOpenSelected,
                                            gameTitle: widget.title,
                                            data: widget.marketDetails,
                                          ),
                                        );
                                      } else {
                                        SnackBarMessage.centeredSnackbar(
                                          text: "Incorrect value",
                                          context: context,
                                        );
                                      }
                                      setState(() {});
                                      // setState(() {
                                      //     firstController.clear();
                                      //     thirdController.clear();
                                      //     amountController.clear();
                                      //   });
                                    },
                                    gradient: kblueGradient,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gameBids.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            height: 30,
                            decoration: const BoxDecoration(
                              gradient: kCustomGradient,
                              borderRadius: kSmallBorderRadius,
                            ),
                            child: BidTileWidget.bidTileWidget(
                                bid: gameBids[index],
                                onpress: () {
                                  setState(() {
                                    gameBids.removeAt(index);
                                  });
                                }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.maxFinite,
            height: 56,
            child: Row(
              children: [
                Expanded(
                    child: KOpenCloseButton(
                  gradient: klightGreyGradient,
                  isLeft: true,
                  title: (gameBids
                      .map((e) => int.parse(e.bidPoints))
                      .fold(0, (prev, curr) => prev + curr)
                      .toString()),
                  onPressed: () {},
                )),
                Expanded(
                  child: KOpenCloseButton(
                    isLeft: false,
                    title: "Submit",
                    gradient: kblueGradient,
                    onPressed: () async {
                      List<Map<String, dynamic>> list = [];
                      for (var bid in gameBids) {
                        final map = {
                          "game_id": bid.gameId.toString(),
                          "game_type": convertToGameTypeFormat(bid.gameType),
                          "session": bid.session,
                          "bid_points": bid.bidPoints.toString(),
                          "open_digit": bid.openDigit.toString(),
                          "close_digit": bid.closeDigit.toString(),
                          "open_panna": bid.openPanna.toString(),
                          "close_panna": bid.closePanna.toString(),
                        };
                        list.add(map);
                      }
                      if (list.isNotEmpty) {
                        final jsonData = await HttpRequests.placeBidRequest(
                            context: context, token: user.token, list: list);
                        if (jsonData.isNotEmpty && jsonData["code"] == "100") {
                          gameBids.clear();
                          firstController.clear();
                          thirdController.clear();
                          amountController.clear();
                          setState(() {});
                          final jsonUserStatus =
                              await HttpRequests.getUserStatusRequest(
                                  context: context, token: user.token);

                          BlocProvider.of<UserStatusCubit>(context)
                              .updateAppUserStatus(
                            UserStatusModel.fromJson(jsonUserStatus),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
