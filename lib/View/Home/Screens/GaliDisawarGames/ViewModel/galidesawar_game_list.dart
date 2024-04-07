import 'package:flutter/material.dart';
import 'package:sm_matka/View/Home/Screens/GaliDisawarGames/Screens/gali_desawar_game_field_screen.dart';

class GaliDesawarGameList {
  static List<Map<String, dynamic>> galiDesawarGameList = [
    {
      "title": "Left Digit",
      "img": "assets/Games/leftDigit.png",
      "onTap":
          (BuildContext context, Map<String, dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GaliDesawarGamesFieldScreen(
              title: "Left Digit",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Right Digit",
      "img": "assets/Games/rightDigit.png",
      "onTap":
          (BuildContext context, Map<String, dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GaliDesawarGamesFieldScreen(
              title: "Right Digit",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Jodi Digit",
      "img": "assets/Games/jodiDigit.png",
      "onTap":
          (BuildContext context, Map<String, dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GaliDesawarGamesFieldScreen(
              title: "Jodi Digit",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },

  ];
}
