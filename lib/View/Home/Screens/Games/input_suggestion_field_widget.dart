import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final List<TextInputFormatter> inputFormatter;
  final List<String> suggestions;
  final TextInputType keyboardType;

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
      child: TypeAheadField<String>(
        controller: widget.controller,
        key: GlobalKey(),
        suggestionsCallback: (search) {
          if (search == "") {
            return widget.suggestions;
          } else {
            return widget.suggestions
                .where((element) => element.contains(search))
                .toList();
          }
        },
        showOnFocus: true,
        focusNode: FocusNode(),
        builder: (context, controller, focusNode) {
          return TextField(
              keyboardType: widget.keyboardType,
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              cursorColor: kWhiteColor,
              cursorHeight: 26,
              inputFormatters: widget.inputFormatter,
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
                labelStyle: const TextStyle(
                    color: kWhiteColor, fontWeight: FontWeight.w400),
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
              ));
        },
        itemBuilder: (BuildContext context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSelected: (data) {
            if (data.isNotEmpty) {
              widget.controller.text = data;
            }

        },
      ),
    );
  }
}
