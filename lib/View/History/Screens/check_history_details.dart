import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/History/Widgets/date_picker_button.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

class CheckHistoryDetails extends StatefulWidget {
  const CheckHistoryDetails(
      {super.key, required this.title, required this.fetchData});
  final String title;
  final Function({
    required BuildContext context,
    required String token,
    required String startDate,
    required String toDate,
  }) fetchData;
  @override
  State<CheckHistoryDetails> createState() => _CheckHistoryDetailsState();
}

class _CheckHistoryDetailsState extends State<CheckHistoryDetails> {
  String convertToTitleCase(String text) {
    List<String> words = text.split('_');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalizedWord = word.substring(0, 1).toUpperCase() +
            word.substring(1).toLowerCase();
        capitalizedWords.add(capitalizedWord);
      }
    }

    return capitalizedWords.join(' ');
  }

//

  DateTime fromDate=DateTime.now();
  DateTime toDate=DateTime.now();
  @override
  void initState() {
    super.initState();
    setState(() {
    DateTime now = DateTime.now();
    fromDate=DateTime(now.year, now.month, now.day, 0, 0, 0);
      
    });
  }
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
          widget.title,
          style: kMediumTextStyle.copyWith(
              color: kblue1color, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
              margin: const EdgeInsets.only( bottom: 10),
              decoration:const BoxDecoration(gradient: klightGreyGradient),
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DatePickerButton(
                          labelText: "From date",
                          onDateSelected: (date) {
                            fromDate=date;
                          },
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: DatePickerButton(
                          labelText: "To date",
                          onDateSelected: (date) {
                            toDate=date;
                          },
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(onPressed: (){
                    setState(() {
                      
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kblue1color,foregroundColor: kBlue1Color,
                  minimumSize:const Size(double.maxFinite, 36)
                  ),
                   label:const Text("submit"),icon:const Icon(Icons.check_rounded),)
                ],
                
              ),
            ),
            Expanded(
              child: StatefulBuilder(builder: (context, secSetstate) {
                return FutureBuilder<Map<String, dynamic>>(
                  future: widget.fetchData(
                      context: context,
                      startDate: fromDate.toString().split('.').first,
                      toDate: toDate.toString().split('.').first,
                      token: user.token),
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
                              // width: 50,
                              child: Text(
                                "No Date Found",
                                style: kMediumCaptionTextStyle.copyWith(
                                    color: kBlue1Color,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!["data"].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              elevation: 2,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: kMediumBorderRadius),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: const BoxDecoration(
                                    color: kblue1color,
                                    borderRadius: kMediumBorderRadius),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${snapshot.data!["data"][index]["game_name"]} (${convertToTitleCase(snapshot.data!["data"][index]["game_type"])})",
                                      style: kSmallTextStyle.copyWith(
                                        color: kBlue3Color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Divider(
                                      height: 20,
                                      thickness: 1,
                                      color: kBlue1Color,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "#${snapshot.data!["data"][index]["game_id"]}",
                                          style:
                                              kSmallCaptionTextStyle.copyWith(
                                            color: kBlue3Color,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Points: ${snapshot.data!["data"][index]["bid_points"]}",
                                          style:
                                              kMediumCaptionTextStyle.copyWith(
                                            color: kBlue3Color,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Digit ${snapshot.data!["data"][index]["close_digit"]}",
                                        style: kSmallCaptionTextStyle.copyWith(
                                          color: kBlue3Color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${snapshot.data!["data"][index]["bidded_at"]}",
                                          style:
                                              kSmallCaptionTextStyle.copyWith(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Session: ${snapshot.data!["data"][index]["session"]}",
                                          style:
                                              kSmallCaptionTextStyle.copyWith(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
