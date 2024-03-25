import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class InputTextFieldWidget extends StatefulWidget {
  const InputTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  bool obsecureText = false;
  @override
  void initState() {
    if (widget.isPassword) {
      obsecureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        obscureText: obsecureText,
        controller: widget.controller,
        cursorColor: kWhiteColor,
        cursorHeight: 26,
        style: kMediumTextStyle.copyWith(color: kWhiteColor),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          constraints: const BoxConstraints(
            maxHeight: 56,
            maxWidth: double.maxFinite,
            minHeight: 56,
            minWidth: double.maxFinite,
          ),
          labelText: widget.labelText,
          labelStyle:
              const TextStyle(color: kWhiteColor, fontWeight: FontWeight.w400),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                  icon: Icon(
                    obsecureText ? Icons.visibility : Icons.visibility_off,
                    color: kWhiteColor,
                  ))
              : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kWhiteColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kWhiteColor),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 1, color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}