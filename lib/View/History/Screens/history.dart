import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/History/Widgets/history_list.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblue1color,
      appBar: AppBar(
          backgroundColor: kBlue1Color,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "History",
            style: kMediumTextStyle.copyWith(
                color: kblue1color, fontWeight: FontWeight.w700),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: HistoryList.historyList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,mainAxisExtent: 120),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: ()async {
                await HistoryList.historyList[index]["onPressed"](context);
              },
              child: Card(
                elevation: 2,
                shape:const RoundedRectangleBorder(borderRadius: kSmallBorderRadius),
                child: Container(
                  decoration: const BoxDecoration(
                      color: kblue1color, borderRadius: kSmallBorderRadius),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                       HistoryList.historyList[index]["img"],
                        width: 46,
                        height: 46,
                        fit: BoxFit.contain,
                      ),
                      const Divider(
                        thickness: 1,
                        color: kBlue1Color,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              HistoryList.historyList[index]["title"],
                              style: kMediumCaptionTextStyle.copyWith(
                                color: kBlue1Color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,size: 14,color: kBlue1Color,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
