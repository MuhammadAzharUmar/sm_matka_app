import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class InputSuggestionTextFieldWidget extends StatefulWidget {
  const InputSuggestionTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    required this.inputFormatter,
    required this.suggestions,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final List<TextInputFormatter> inputFormatter;
  final List<String> suggestions;

  @override
  State<InputSuggestionTextFieldWidget> createState() =>
      _InputSuggestionTextFieldWidgetState();
}

class _InputSuggestionTextFieldWidgetState
    extends State<InputSuggestionTextFieldWidget> {
  bool obsecureText = false;
  @override
  void initState() {
    if (widget.isPassword) {
      obsecureText = true;
    }
    super.initState();
  }

  // static GlobalKey<AutoCompleteTextFieldState<String>> fieldKey =
  //     GlobalKey<AutoCompleteTextFieldState<String>>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: AutoCompleteTextField<String>(
        inputFormatters: widget.inputFormatter,
        // obscureText: obsecureText,
        controller: widget.controller,
        cursorColor: kWhiteColor,
        // cursorHeight: 26,
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
        itemSubmitted: (data) {
          setState(() {
            if (data.isNotEmpty) {
              widget.controller.text = data;
            }
          });
          // FocusScope.of(context).unfocus();
        },
        key: GlobalKey(),
        suggestions: widget.suggestions,
        itemBuilder: (BuildContext context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        itemSorter: (String a, String b) {
          return a.compareTo(b);
        },
        itemFilter: (String suggestion, String query) {
          return suggestion.toLowerCase().startsWith(query.toLowerCase());
        },
        submitOnSuggestionTap: true,
        clearOnSubmit: false,
      ),
    );
  }
}
