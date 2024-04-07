import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Screens/gali_disawar_game.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Screens/starline_game.dart';

class GaliDisawarGameBtmSheet {
  static galiDisawarGameBtmSheet({required BuildContext context}) async {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      isScrollControlled: true,

      // isDismissible: false,
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: 200,
        minWidth: double.maxFinite,
        maxWidth: double.maxFinite,
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStatebtmsheet) {
          return Container(
            height: 200,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: klightGreyGradient,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const StarlineGameScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: kMediumBorderRadius,
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 130,
                                  width: 130,
                                  child: Lottie.asset(
                                    "assets/General/animation.json",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 130,
                                  width: 130,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/General/starlinegame.png",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "PLAY STARLINE",
                            style: kSmallTextStyle.copyWith(color: kBlue1Color),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GaliDisawarGame(),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: kMediumBorderRadius,
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 130,
                                  width: 130,
                                  child: Lottie.asset(
                                    "assets/General/animation.json",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 130,
                                  width: 130,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/General/galigame.png",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Play GALI DS",
                            style: kSmallTextStyle.copyWith(color: kBlue1Color),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
