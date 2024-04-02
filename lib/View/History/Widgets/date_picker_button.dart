import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class DatePickerButton extends StatefulWidget {
  final String labelText;
  final Function(DateTime) onDateSelected;

  const DatePickerButton({
    super.key,
    required this.labelText,
    required this.onDateSelected,
  });

  @override
  DatePickerButtonState createState() => DatePickerButtonState();
}

class DatePickerButtonState extends State<DatePickerButton> {
  late String selectedDate = DateTime.now().toString().split(' ')[0];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = picked.toString().split(' ')[0];
      });
      DateTime now = DateTime.now();
      if (picked.year == now.year &&
          picked.month == now.month &&
          picked.day == now.day) {
        DateTime newDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
        if (widget.labelText.contains("From")) {
          widget.onDateSelected(newDate);
        } else {
          widget.onDateSelected(DateTime.now());
        }
      } else {
        widget.onDateSelected(picked);
      }
    } else {
      DateTime now = DateTime.now();
      DateTime newDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
      if (widget.labelText.contains("From")) {
        widget.onDateSelected(newDate);
      } else {
        widget.onDateSelected(DateTime.now());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.labelText,
          style: kMediumCaptionTextStyle.copyWith(color: kBlue1Color),
        ),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          style: ElevatedButton.styleFrom(
              backgroundColor: kBlue1Color,
              foregroundColor: kblue1color,
              minimumSize: const Size(double.maxFinite, 36)),
          child: Text(selectedDate),
        ),
      ],
    );
  }
}
