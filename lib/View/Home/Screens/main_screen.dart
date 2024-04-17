import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Screens/funds.dart';
import 'package:sm_matka/View/History/Screens/history.dart';
import 'package:sm_matka/View/Home/Screens/home.dart';
import 'package:sm_matka/View/Home/Widgets/bottom_nav_bar.dart';
import 'package:sm_matka/View/Profile/Screens/profile.dart';
import 'package:sm_matka/View/Settings/Screens/settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.currentIndex, this.textData = ""});
  final int currentIndex;
  final String textData;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    pageController = PageController(initialPage: widget.currentIndex);
    notchController = NotchBottomBarController(index: widget.currentIndex);
    currentIndex = widget.currentIndex;

    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) async {});
  }

  late PageController pageController;
  late NotchBottomBarController notchController;

  late int currentIndex;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                insetPadding: const EdgeInsets.all(0),
                content: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: const BoxDecoration(
                      color: kWhiteColor, borderRadius: kLargeBorderRadius),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Exit App",
                        style: kLargeTextStyle.copyWith(
                            color: kBlue1Color, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Are you sure,\nyou want to Exit the Game?",
                        style: kSmallTextStyle.copyWith(
                            color: kBlue1Color, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: KLoginButton(
                                title: "No",
                                gradient: klightGreyGradient,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: KLoginButton(
                                title: "Yes",
                                gradient: kblueGradient,
                                onPressed: () async {
                                  SystemNavigator.pop();
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
      canPop: false,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            Home(),
            History(),
            Profile(),
            Funds(),
            Settings(),
          ],
          onPageChanged: (value) {
            // setState(() {
            currentIndex = value;
            // });
          },
        ),
        bottomNavigationBar: CustomBottomAppBar(
          notchController: notchController,
          currentIndex: currentIndex,
          onPressed: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
