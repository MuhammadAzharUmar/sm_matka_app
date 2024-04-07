import 'package:flutter/material.dart';
import 'package:sm_matka/View/Home/Screens/Games/games_fields_screen.dart';

class MainGameList {
  static List<Map<String, dynamic>> mainGameList = [
    {
      "title": "Single Digit",
      "img": "assets/Games/singleDigit.png",
      "onTap": (BuildContext context,Map<String,dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GamesFieldScreen(
              title: "Single Digit",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Jodi Digit",
      "img": "assets/Games/jodiDigit.png",
      "onTap": (BuildContext context,Map<String,dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GamesFieldScreen(
              title: "Jodi Digit",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Single Panna",
      "img": "assets/Games/singlePanna.png",
      "onTap": (BuildContext context,Map<String,dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GamesFieldScreen(
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
      "onTap": (BuildContext context,Map<String,dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GamesFieldScreen(
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
      "onTap": (BuildContext context,Map<String,dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GamesFieldScreen(
              title: "Triple Panna",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Half Sangam",
      "img": "assets/Games/halfSangam.png",
      "onTap": (BuildContext context,Map<String,dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GamesFieldScreen(
              title: "Half Sangam",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
    {
      "title": "Full Sangam",
      "img": "assets/Games/fullSangam.png",
      "onTap": (BuildContext context,Map<String,dynamic> marketDetails) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GamesFieldScreen(
              title: "Full Sangam",
              marketDetails: marketDetails,
            ),
          ),
        );
      },
    },
  ];
}
