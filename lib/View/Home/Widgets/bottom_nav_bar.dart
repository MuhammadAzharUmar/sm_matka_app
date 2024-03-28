import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onPressed,
    required this.notchController,
  });
  final int currentIndex;
  final Function(int) onPressed;
  final NotchBottomBarController notchController;
  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  // int selectedIndex = 0;
  // NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  @override
  void initState() {
    super.initState();
    // selectedIndex = widget.currentIndex;
    // _controller = NotchBottomBarController(index: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: AnimatedNotchBottomBar(
        color: kWhiteColor,
        notchColor: kBlue1Color,
        notchBottomBarController: widget.notchController,
        kBottomRadius: 40,
        kIconSize: 24,
        durationInMilliSeconds: 100,
        onTap: (index) {
          widget.onPressed(index);
        },
        bottomBarItems: const [
          
           BottomBarItem(
            inActiveItem:  Icon(Icons.home_outlined,color: kBlue1Color,),
            activeItem: Icon(Icons.home_outlined,color: kWhiteColor,),
            itemLabel: 'Home',
          ),
           BottomBarItem(
            inActiveItem:  Icon(Icons.history,color: kBlue1Color,),
            activeItem: Icon(Icons.history,color: kWhiteColor,),
            itemLabel: 'History',
          ),
           BottomBarItem(
            inActiveItem:  Icon(Icons.person_3_outlined,color: kBlue1Color,),
            activeItem: Icon(Icons.person_3_outlined,color: kWhiteColor,),
            itemLabel: 'Profile',
          ),
           BottomBarItem(
            inActiveItem:  Icon(Icons.money,color: kBlue1Color,),
            activeItem: Icon(Icons.money,color: kWhiteColor,),
            itemLabel: 'Money',
          ),
           BottomBarItem(
            inActiveItem:  Icon(Icons.settings,color: kBlue1Color,),
            activeItem: Icon(Icons.settings,color: kWhiteColor,),
            itemLabel: 'Settings',
          ),
        ],
      ),
    );
  }
}
