import 'package:flutter/material.dart';
import 'package:sm_matka/View/History/Screens/check_history_details.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class HistoryList {
  static List<Map<String, dynamic>> historyList = [
    {
      "title": "Main Game Bid",
      "img": "assets/General/bid.png",
      "onPressed": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckHistoryDetails(
              title: "Main Game Bid",
              fetchData: (
                  {required context,
                  required startDate,
                  required toDate,
                  required token}) async {
                return await HttpRequests.bidHistoryRequest(
                    context: context,
                    token: token,
                    fromDate: startDate,
                    toDate: toDate);
              },
            ),
          ),
        );
      },
    },
    {
      "title": "Main Game Win",
      "img": "assets/General/win.png",
      "onPressed": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckHistoryDetails(
              title: "Main Game Win",
              fetchData: (
                  {required context,
                  required startDate,
                  required toDate,
                  required token}) async {
                return await HttpRequests.winHistoryRequest(
                    context: context,
                    token: token,
                    fromDate: startDate,
                    toDate: toDate);
              },
            ),
          ),
        );
      },
    },
    {
      "title": "Starline Bid",
      "img": "assets/General/bid.png",
      "onPressed": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckHistoryDetails(
              title: "Starline Bid",
              fetchData: (
                  {required context,
                  required startDate,
                  required toDate,
                  required token}) async {
                return await HttpRequests.winHistoryRequest(
                    context: context,
                    token: token,
                    fromDate: startDate,
                    toDate: toDate);
              },
            ),
          ),
        );
      },
    },
    {
      "title": "Starline Win",
      "img": "assets/General/win.png",
      "onPressed": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckHistoryDetails(
              title: "Starline Win",
              fetchData: (
                  {required context,
                  required startDate,
                  required toDate,
                  required token}) async {
                return await HttpRequests.winHistoryRequest(
                    context: context,
                    token: token,
                    fromDate: startDate,
                    toDate: toDate);
              },
            ),
          ),
        );
      },
    },
    {
      "title": "GaliDisawar Bid",
      "img": "assets/General/bid.png",
      "onPressed": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckHistoryDetails(
              title: "GaliDisawar Bid",
              fetchData: (
                  {required context,
                  required startDate,
                  required toDate,
                  required token}) async {
                return await HttpRequests.winHistoryRequest(
                    context: context,
                    token: token,
                    fromDate: startDate,
                    toDate: toDate);
              },
            ),
          ),
        );
      },
    },
    {
      "title": "GaliDisawar Win",
      "img": "assets/General/win.png",
      "onPressed": (BuildContext context) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckHistoryDetails(
              title: "GaliDisawar Win",
              fetchData: (
                  {required context,
                  required startDate,
                  required toDate,
                  required token}) async {
                return await HttpRequests.winHistoryRequest(
                    context: context,
                    token: token,
                    fromDate: startDate,
                    toDate: toDate);
              },
            ),
          ),
        );
      },
    },
  ];
}
