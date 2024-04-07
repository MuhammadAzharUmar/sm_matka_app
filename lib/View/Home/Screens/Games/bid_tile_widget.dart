import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Model/gali_desawar_game_model.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Model/starline_game_model.dart';
import 'package:sm_matka/View/Home/Screens/Games/game_bid_model.dart';

class BidTileWidget {
  static Widget bidTileWidget(
      {required GameBid bid, required VoidCallback onpress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                bid.gameType == "Full Sangam"
                    ? "OpenPanna ${bid.openPanna} "
                    : bid.gameType == "Half Sangam"
                        ? "${bid.session == "Open" ? "Digit ${bid.openDigit}" : "Panna ${bid.closePanna}"} "
                        : (bid.gameType == "Single Panna" ||
                                bid.gameType == "Double Panna" ||
                                bid.gameType == "Triple Panna")
                            ? "Panna ${bid.session == "Open" ? bid.openPanna : bid.closePanna}"
                            : "Digit ${bid.session == "Open" ? bid.openDigit : bid.closeDigit}",
                style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
              ),
            ),
          ),
        ),
        bid.gameType == "Jodi Digit"
            ? Container(
                width: 0,
              )
            : Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      bid.gameType == "Full Sangam"
                          ? "  ClosePanna ${bid.closePanna}"
                          : bid.gameType == "Half Sangam"
                              ? "${bid.session == "Open" ? " Panna ${bid.closePanna}" : "Digit ${bid.openDigit}"} "
                              : bid.session,
                      style:
                          kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
                    ),
                  ),
                ),
              ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "${bid.bidPoints} Points",
                style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onpress,
                  icon: const Icon(
                    Icons.clear,
                    color: kWhiteColor,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  static Widget galiDesawarbidTileWidget(
      {required GaliDesawarGameBid bid, required VoidCallback onpress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                bid.gameType=="Right Digit"?"Digit ${bid.rightDigit}" : "Digit ${bid.leftDigit}",
                style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
              ),
            ),
          ),
        ),
        
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "${bid.bidPoints} Points",
                style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onpress,
                  icon: const Icon(
                    Icons.clear,
                    color: kWhiteColor,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget starlinebidTileWidget(
      {required StarlineGameBid bid, required VoidCallback onpress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                bid.gameType=="Single Digit"?"Digit ${bid.digit}" : "Panna ${bid.panna}",
                style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
              ),
            ),
          ),
        ),
        
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "${bid.bidPoints} Points",
                style: kMediumCaptionTextStyle.copyWith(color: kWhiteColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onpress,
                  icon: const Icon(
                    Icons.clear,
                    color: kWhiteColor,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
