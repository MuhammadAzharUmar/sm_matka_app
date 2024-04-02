import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class InputTextFieldWidget extends StatefulWidget {
  const InputTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.inputFormatter=const [],
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatter;

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
        inputFormatters:widget.inputFormatter,
       
        obscureText: obsecureText,
        controller: widget.controller,
        cursorColor: kblue1color,
        cursorHeight: 26,
        style: kMediumTextStyle.copyWith(color: kblue1color),
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
              const TextStyle(color: kblue1color, fontWeight: FontWeight.w400),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                  icon: Icon(
                    obsecureText ? Icons.visibility : Icons.visibility_off,
                    color: kblue1color,
                  ))
              : null,
          border: UnderlineInputBorder(
            borderSide: const BorderSide(color: kblue1color, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kblue1color),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 1, color: kblue1color),
          ),
        ),
      ),
    );
  }
}
