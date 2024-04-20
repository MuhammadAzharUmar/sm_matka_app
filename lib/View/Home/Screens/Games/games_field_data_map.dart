import 'package:flutter/services.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Model/gali_desawar_game_model.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Model/starline_game_model.dart';
import 'package:sm_matka/View/Home/Screens/Games/allowed_digits_list.dart';
import 'package:sm_matka/View/Home/Screens/Games/game_bid_model.dart';

class GamesFieldsDataMap {
  static Map<String, dynamic> gamesFieldsDataMap = {
    "Single Digit": {
      "first_field_title": "Enter Single Digit",
      "first_field_title_allowed": AllowedDigitsList.singleDigits,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1)
      ],
      "second_field_title": "Enter Amount",
    },
    "Left Digit": {
      "first_field_title": "Enter Left Digit",
      "first_field_title_allowed": AllowedDigitsList.singleDigits,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1)
      ],
      "second_field_title": "Enter Amount",
    },
    "Right Digit": {
      "first_field_title": "Enter Right Digit",
      "first_field_title_allowed": AllowedDigitsList.singleDigits,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1)
      ],
      "second_field_title": "Enter Amount",
    },
    "Jodi Digit": {
      "first_field_title": "Enter Jodi Digit",
      "first_field_title_allowed": AllowedDigitsList.jodiDigit,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2)
      ],
      "second_field_title": "Enter Amount",
    },
    "Single Panna": {
      "first_field_title": "Enter Single Panna",
      "first_field_title_allowed": AllowedDigitsList.singlePanna,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3)
      ],
      "second_field_title": "Enter Amount",
    },
    "Double Panna": {
      "first_field_title": "Enter Double Panna",
      "first_field_title_allowed": AllowedDigitsList.doublePanna,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3)
      ],
      "second_field_title": "Enter Amount",
    },
    "Triple Panna": {
      "first_field_title": "Enter Triple Panna",
      "first_field_title_allowed": AllowedDigitsList.triplePanna,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3)
      ],
      "second_field_title": "Enter Amount",
    },
    "Half Sangam": {
      "first_field_title": "Enter Open Digit",
      "first_field_title_close": "Enter Close Panna",
      "third_field_title": "Enter Close Panna",
      "third_field_title_close": "Enter Open Digit",
      "second_field_title": "Enter Amount",
      "first_field_title_allowed": AllowedDigitsList.singleDigits,
      "third_field_title_allowed": AllowedDigitsList.panna,

      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3)
      ],
    },
    "Full Sangam": {
      "first_field_title": "Enter Open Panna",
      "third_field_title": "Enter Close Panna",
      "second_field_title": "Enter Amount",
      "first_field_title_allowed": AllowedDigitsList.panna,
      "inputFormater": [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3)
      ],
    },
  };
  //***************************************************************** */
  // function to get gamebid based on game selected
  static GameBid getGameBid(
      {required String first,
      required String second,
      required String amount,
      required bool isOpen,
      required String gameTitle,
      required Map<String, dynamic> data}) {
    if (gameTitle == "Single Digit") {
      return GameBid(
        gameId: data["id"],
        gameType: gameTitle,
        session: isOpen ? "Open" : "Close",
        bidPoints: amount,
        openDigit: isOpen ? first : "",
        closeDigit: !isOpen ? first : "",
        openPanna: "",
        closePanna: "",
      );
    } else if (gameTitle == "Jodi Digit") {
      return GameBid(
        gameId: data["id"],
        gameType: gameTitle,
        // session: "",
        session: isOpen ? "Open" : "Close",
        bidPoints: amount,
        openDigit: isOpen ? first : "",
        closeDigit: !isOpen ? first : "",
        openPanna: "",
        closePanna: "",
      );
    } else if (gameTitle == "Single Panna") {
      return GameBid(
        gameId: data["id"],
        gameType: gameTitle,
        session: isOpen ? "Open" : "Close",
        bidPoints: amount,
        openDigit: "",
        closeDigit: "",
        openPanna: isOpen ? first : "",
        closePanna: !isOpen ? first : "",
      );
    } else if (gameTitle == "Double Panna") {
      return GameBid(
        gameId: data["id"],
        gameType: gameTitle,
        session: isOpen ? "Open" : "Close",
        bidPoints: amount,
        openDigit: "",
        closeDigit: "",
        openPanna: isOpen ? first : "",
        closePanna: !isOpen ? first : "",
      );
    } else if (gameTitle == "Triple Panna") {
      return GameBid(
        gameId: data["id"],
        gameType: gameTitle,
        session: isOpen ? "Open" : "Close",
        bidPoints: amount,
        openDigit: "",
        closeDigit: "",
        openPanna: isOpen ? first : "",
        closePanna: !isOpen ? first : "",
      );
    } else if (gameTitle == "Half Sangam") {
      return GameBid(
        gameId: data["id"],
        gameType: gameTitle,
        session: isOpen ? "Open" : "Close",
        bidPoints: amount,
        openDigit: isOpen ? first : second,
        closeDigit: "",
        openPanna: "",
        closePanna: isOpen ? second : first,
      );
    } else {
      return GameBid(
        gameId: data["id"],
        gameType: gameTitle,
        session: isOpen ? "Open" : "Close",
        bidPoints: amount,
        openDigit: "",
        closeDigit: "",
        openPanna: first,
        closePanna: second,
      );
    }
  }

  static GaliDesawarGameBid getGaliDesawarBid(
      {required String first,
      required String amount,
      required String gameTitle,
      required Map<String, dynamic> data}) {
    if (gameTitle == "Left Digit") {
      return GaliDesawarGameBid(
          gameId: data["id"],
          gameType: gameTitle,
          session: "Open",
          bidPoints: amount,
          leftDigit: first,
          rightDigit: "");
    } else if (gameTitle == "Right Digit") {
      return GaliDesawarGameBid(
          gameId: data["id"],
          gameType: gameTitle,
          session: "Open",
          bidPoints: amount,
          leftDigit: "",
          rightDigit: first);
    } else {
      return GaliDesawarGameBid(
          gameId: data["id"],
          gameType: gameTitle,
          session: "Open",
          bidPoints: amount,
          leftDigit: first,
          rightDigit: "");
    }
  }

  static StarlineGameBid getStarlineGameBid(
      {required String first,
      required String amount,
      required String gameTitle,
      required Map<String, dynamic> data}) {
    if (gameTitle == "Single Digit") {
      return StarlineGameBid(
          gameId: data["id"],
          gameType: gameTitle,
          session: "Open",
          bidPoints: amount,
          digit: first,
          panna: "");
    } else if (gameTitle == "Single Panna") {
      return StarlineGameBid(
          gameId: data["id"],
          gameType: gameTitle,
          session: "Open",
          bidPoints: amount,
          digit: "",
          panna: first);
    } else if (gameTitle == "Double Panna") {
      return StarlineGameBid(
          gameId: data["id"],
          gameType: gameTitle,
          session: "Open",
          bidPoints: amount,
          digit: "",
          panna: first);
    } else {
      return StarlineGameBid(
          gameId: data["id"],
          gameType: gameTitle,
          session: "Open",
          bidPoints: amount,
          digit: "",
          panna: first);
    }
  }
}
