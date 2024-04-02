import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';

class KLoginButton extends StatelessWidget {
  const KLoginButton({
    super.key,
    required this.title,
    required this.onPressed, this.gradient,
  });
  final String title;
  final VoidCallback onPressed;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradient, borderRadius: BorderRadius.circular(30),border: Border.all(color: k2ndColor,width: 2)),
      height: 36,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: kblue1color,
              elevation: 0,
              minimumSize: const Size(100, 36),
              maximumSize: const Size(100, 36),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
          child: Text(title)),
    );
  }
}
