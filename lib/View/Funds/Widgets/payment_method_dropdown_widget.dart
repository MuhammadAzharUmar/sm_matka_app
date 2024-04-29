import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

class PaymentMethodDropdownWidget extends StatefulWidget {
  const PaymentMethodDropdownWidget({
    super.key,
    required this.dropDownValue,
    required this.selectedDropDownValue,
    required this.onChange,
  });
  final int dropDownValue;
  final String selectedDropDownValue;
  final Function(String, int) onChange;

  @override
  State<PaymentMethodDropdownWidget> createState() =>
      _PaymentMethodDropdownWidgetState();
}

class _PaymentMethodDropdownWidgetState
    extends State<PaymentMethodDropdownWidget> {
  int dropdownvalue = 0;
  @override
  void initState() {
    super.initState();
    dropdownvalue = widget.dropDownValue;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
      return Container(
        height: 46,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(color: kBlue1Color, width: 1),
          borderRadius: kSmallBorderRadius,
        ),
        child: DropdownButton(
            value: dropdownvalue,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 24,
            ),
            underline: Container(),
            style: kSmallTextStyle.copyWith(
                color: kBlackColor, fontWeight: FontWeight.bold),
            isExpanded: true,
            dropdownColor: kWhiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            items: [
              const DropdownMenuItem(
                value: 0,
                child: Text("Select Payment Method"),
              ),
              if (user.data.phonepeMobileNo.isNotEmpty)
                DropdownMenuItem(
                  value: 1,
                  child: Text("PhonePe ${user.data.phonepeMobileNo}"),
                ),
              if (user.data.gpayMobileNo.isNotEmpty)
                DropdownMenuItem(
                  value: 2,
                  child: Text("Google Pay ${user.data.gpayMobileNo}"),
                ),
              if (user.data.paytmMobileNo.isNotEmpty)
                DropdownMenuItem(
                  value: 3,
                  child: Text("Paytm ${user.data.paytmMobileNo}"),
                ),
              if (user.data.bankAccountNo.isNotEmpty)
                DropdownMenuItem(
                  value: 4,
                  child: Text("Bank ${user.data.bankAccountNo}"),
                ),
            ],
            onChanged: (value) async {
              dropdownvalue = value!.toInt();
              String selectedValue;
              switch (value) {
                case 0:
                  selectedValue = "Select Payment Method";
                  break;
                case 1:
                  selectedValue = "phonepe_mobile_no";
                  break;
                case 2:
                  selectedValue = "gpay_mobile_no";
                  break;
                case 3:
                  selectedValue = "paytm_mobile_no";
                  break;
                case 4:
                  selectedValue = "bank_name";
                  break;

                default:
                  selectedValue = 'Select payment method';
              }
              await widget.onChange(selectedValue, value);
            }),
      );
    });
  }
}
