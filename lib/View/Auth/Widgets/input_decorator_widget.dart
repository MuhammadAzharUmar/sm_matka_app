import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class InputDecoratorWidget extends StatelessWidget {
  const InputDecoratorWidget({
    super.key,
    required this.child,
    required this.title,
  });
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // child: InputDecorator(
        // decoration: InputDecoration(
        //   label: Container(
        //     height: 56,
        //     width: 150,
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(30),
        //       gradient: klightGreyGradient,
        //       border: Border.all(color: kWhiteColor, width: 1.5),
        //     ),
        //     child: FittedBox(
        //       fit: BoxFit.scaleDown,
        //       child: Text(
        //         title,
        //         style: kMediumTextStyle.copyWith(
        //           color: kBlueColor,
        //           fontWeight: FontWeight.w700,
        //         ),
        //       ),
        //     ),
        //   ),

        //   // labelText: 'Personalia',
        //   floatingLabelAlignment: FloatingLabelAlignment.center,
        //   border: const OutlineInputBorder(
        //       borderRadius: kMediumBorderRadius,
        //       borderSide: BorderSide(
        //         color: kWhiteColor,
        //         width: 1.2,
        //       )),
        //   focusedBorder: const OutlineInputBorder(
        //       borderRadius: kMediumBorderRadius,
        //       borderSide: BorderSide(
        //         color: kWhiteColor,
        //         width: 1.2,
        //       )),
        //   enabledBorder: const OutlineInputBorder(
        //       borderRadius: kMediumBorderRadius,
        //       borderSide: BorderSide(
        //         color: kWhiteColor,
        //         width: 1.2,
        //       )),
        // ),
        child: Column(
          children: [
            Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: kLargeTextStyle.copyWith(color: k2ndColor,fontWeight: FontWeight.w800,shadows: [
                    const  BoxShadow(color: kBlue1Color,offset: Offset(2, 2),blurRadius: 5,spreadRadius: 5)
                    ]),
                  ),
                ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: child,
            ),
          ],
        ),
      // ),
    );
  }
}
