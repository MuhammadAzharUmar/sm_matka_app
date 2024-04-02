import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

class GamesRates extends StatefulWidget {
  const GamesRates({super.key});

  @override
  State<GamesRates> createState() => _GamesRatesState();
}

class _GamesRatesState extends State<GamesRates> {
  //custom function
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
          "Game Rates",
          style: kMediumTextStyle.copyWith(
              color: kblue1color, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
        
        return FutureBuilder(
          future: HttpRequests.gameRatesRequest(
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              convertToTitleCase(
                                  snapshot.data!["data"][index]["name"]),
                              style: kMediumTextStyle.copyWith(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                    Text(snapshot.data!["data"][index]
                                        ["cost_amount"]),
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
                                    Text(snapshot.data!["data"][index]
                                        ["earning_amount"]),
                                  ],
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
    );
  }
}
