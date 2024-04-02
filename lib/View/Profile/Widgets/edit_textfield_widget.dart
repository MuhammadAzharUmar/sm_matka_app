import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class EditTextFieldWidget extends StatefulWidget {
  const EditTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.inputFormatter = const [],
    required this.hintText, required this.isReadOnly,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final bool isReadOnly;
  final List<TextInputFormatter>? inputFormatter;

  @override
  State<EditTextFieldWidget> createState() => _EditTextFieldWidgetState();
}

class _EditTextFieldWidgetState extends State<EditTextFieldWidget> {
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
        readOnly: widget.isReadOnly,
        inputFormatters: widget.inputFormatter,
        obscureText: obsecureText,
        controller: widget.controller,
        cursorColor: kBlue1Color,
        cursorHeight: 26,
        style: kMediumTextStyle.copyWith(color: kBlue1Color),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          constraints: const BoxConstraints(
            maxHeight: 56,
            maxWidth: double.maxFinite,
            minHeight: 56,
            minWidth: double.maxFinite,
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 100, maxWidth: 100),
          prefixIcon: Container(
              height: 20,
              alignment: Alignment.center,
              child: Text("${widget.labelText}  ",
                  style: const TextStyle(
                      color: kBlue1Color, fontWeight: FontWeight.w400))),

          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                  icon: Icon(
                    obsecureText ? Icons.visibility : Icons.visibility_off,
                    color: kBlue1Color,
                  ))
              : null,
          border: UnderlineInputBorder(
            borderSide: const BorderSide(color: kBlue1Color, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kBlue1Color),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 1, color: kBlue1Color),
          ),
        ),
      ),
    );
  }
}
