import 'package:flutter/material.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Screens/starline_game_field_screen.dart';

class StarlineGameList {
  static List<Map<String, dynamic>> starlineGameList = [
    {
      "title": "Single Digit",
      "img": "assets/Games/singleDigit.png",
      "onTap":
          (BuildContext context, Map<String, dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StarlineGamesFieldScreen(
              title: "Single Digit",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Single Panna",
      "img": "assets/Games/singlePanna.png",
      "onTap":
          (BuildContext context, Map<String, dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StarlineGamesFieldScreen(
              title: "Single Panna",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Double Panna",
      "img": "assets/Games/doublePanna.png",
      "onTap":
          (BuildContext context, Map<String, dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StarlineGamesFieldScreen(
              title: "Double Panna",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Triple Panna",
      "img": "assets/Games/triplePanna.png",
      "onTap":
          (BuildContext context, Map<String, dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StarlineGamesFieldScreen(
              title: "Triple Panna",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
  ];
}
