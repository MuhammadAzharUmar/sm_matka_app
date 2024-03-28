import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
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
    );
  }
}
