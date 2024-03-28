import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Home/Widgets/crousel_slider.dart';
import 'package:sm_matka/View/Home/Widgets/home_appbar_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.maxFinite, 56),
        child: HomeAppBarWidget(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomSliderWidget(),
          Container(
            // height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 4),
              itemBuilder: (context, index) {
                return ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kBlue1Color.withOpacity(.9),
                        foregroundColor: kWhiteColor,
                        elevation: 0,
                        // minimumSize: const Size(130, 40),
                        // maximumSize: const Size(130, 40),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: kWhiteColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10)),
                    icon: Image.asset(
                      "assets/Auth/whatsapp.png",
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                    ),
                    label: const Text("Chat Now"));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.only(left: 40, right: 15),
            height: 46,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30,
                ),
                gradient: kCustomGradient),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "GALI DISAWAR GAME",
                  style: kSmallTextStyle.copyWith(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                const Icon(
                  Icons.arrow_circle_right,
                  color: kWhiteColor,
                  size: 24,
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: kSmallBorderRadius,
                  border: Border.all(
                    color: kBlue1Color,
                    width: 2,
                  ),
                ),
                child: const Row(
                  children: [
                    // Container(
                    //   height: 40,
                    //   width: 40,
                    //   child: Image.asset(
                    //     "assets/General/graph.png",
                    //     width: 40,
                    //     height: 40,
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
