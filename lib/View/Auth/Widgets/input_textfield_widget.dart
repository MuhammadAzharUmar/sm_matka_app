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
    this.inputFormatter=const [],  this.keyboardType=TextInputType.text, this.onChange,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType keyboardType;
  final Function(String)? onChange;

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
      child:
       TextFormField(
        onChanged: widget.onChange,
        keyboardType: widget.keyboardType,
        inputFormatters:widget.inputFormatter,
       autocorrect: false,
       enableSuggestions: false,
       
        obscureText: obsecureText,
        controller: widget.controller,
        cursorColor: kWhiteColor,
        cursorHeight: 26,
        style: kMediumTextStyle.copyWith(color: kWhiteColor,decoration: TextDecoration.none,decorationThickness: 0),
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
                    obsecureText ? Icons.visibility_off : Icons.visibility,
                    color: kWhiteColor,
                  ))
              : null,
          border: UnderlineInputBorder(
            borderSide: const BorderSide(color: kWhiteColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kWhiteColor),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 1, color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
