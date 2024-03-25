import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';

class KLoginButton extends StatelessWidget {
  const KLoginButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: kblueGradient, borderRadius: BorderRadius.circular(30)),
      height: 36,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: kWhiteColor,
              elevation: 0,
              minimumSize: const Size(100, 36),
              maximumSize: const Size(100, 36),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
          child: Text(title)),
    );
  }
}
