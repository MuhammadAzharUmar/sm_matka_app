import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';

class KLoginButton extends StatelessWidget {
  const KLoginButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.gradient,
      this.loadingstate});
  final String title;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final AppLoadingStates? loadingstate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLoadingCubit, AppLoadingStates>(
        builder: (context, appLoadingStates) {
      return Container(
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: k2ndColor, width: 2)),
        height: 36,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: kWhiteColor,
                elevation: 0,
                minimumSize: const Size(100, 36),
                maximumSize: const Size(100, 36),
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
            child: appLoadingStates == loadingstate
                ? Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: kWhiteColor,
                      strokeWidth: 2,
                    ),
                  )
                : Text(title)),
      );
    });
  }
}
