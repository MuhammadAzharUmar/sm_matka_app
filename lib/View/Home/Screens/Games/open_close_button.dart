import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';

class KOpenCloseButton extends StatelessWidget {
  const KOpenCloseButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.gradient,
    required this.isLeft,
    this.loadingstate
  });
  final String title;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final bool isLeft;
  final AppLoadingStates? loadingstate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLoadingCubit,AppLoadingStates>(
      builder: (context,appLoadingState) {
        return Container(
          decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.only(
                topLeft:
                    isLeft ? const Radius.circular(10) : const Radius.circular(0),
                bottomLeft:
                    isLeft ? const Radius.circular(10) : const Radius.circular(0),
                topRight:
                    !isLeft ? const Radius.circular(10) : const Radius.circular(0),
                bottomRight:
                    !isLeft ? const Radius.circular(10) : const Radius.circular(0),
              ),
              border: Border.all(color: kBlackColor, width: 1)),
          height: 36,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor:
                    gradient == klightGreyGradient ? kBlue1Color : kWhiteColor,
                // RegExp(r'^[0-9]+$').hasMatch(title) || title == "Open"
                //     ? kBlue1Color
                //     : kWhiteColor,
                elevation: 0,
                minimumSize: const Size(100, 36),
                maximumSize: const Size(100, 36),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
            child: RegExp(r'^[0-9]+$').hasMatch(title)
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Total Bid Amount\n$title",
                      textAlign: TextAlign.center,
                      style: kMediumCaptionTextStyle.copyWith(),
                    ))
                : appLoadingState == loadingstate
                ? Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: kWhiteColor,
                      strokeWidth: 2,
                    ),
                  ) :Text(title),
          ),
        );
      }
    );
  }
}
