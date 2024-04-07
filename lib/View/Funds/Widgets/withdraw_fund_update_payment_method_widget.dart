import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Funds/Screens/bank_details_update.dart';
import 'package:sm_matka/View/Funds/Screens/update_phonepe_paytm_gpay.dart';

class WithdrawFundUpdatePaymentMethodWidget extends StatelessWidget {
  const WithdrawFundUpdatePaymentMethodWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: kMediumBorderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
            color: kWhiteColor, borderRadius: kMediumBorderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BankDetailsUpdateScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        border: Border.all(
                          color: kBlue1Color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      "assets/Fund/bank.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Text(
                    "Bank",
                    style: kMediumCaptionTextStyle.copyWith(
                      color: kBlue1Color,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UpdatePhonepeGpayPaytmScreen(
                      screenTitle: "Phone Pe",
                      logoUrl: "assets/Fund/phonepe.png",
                      logoTitle: "Hey, Whats your PhonePe number?",
                      logoSubtitle:
                          "Enter your PhonePe number to use in withdrawel.",
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/Fund/phonepe.png",
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "PhonePe",
                    style: kMediumCaptionTextStyle.copyWith(
                      color: kBlue1Color,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UpdatePhonepeGpayPaytmScreen(
                      screenTitle: "Google Pay",
                      logoUrl: "assets/Fund/gpay.png",
                      logoTitle: "Hey, Whats your Google Pay number?",
                      logoSubtitle:
                          "Enter your Google Pay number to use in withdrawel.",
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        border: Border.all(
                          color: kBlue1Color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      "assets/Fund/gpay.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Text(
                    "Google Pay",
                    style: kMediumCaptionTextStyle.copyWith(
                      color: kBlue1Color,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UpdatePhonepeGpayPaytmScreen(
                      screenTitle: "PayTm",
                      logoUrl: "assets/Fund/paytm.png",
                      logoTitle: "Hey, Whats your PayTm number?",
                      logoSubtitle:
                          "Enter your PayTm number to use in withdrawel.",
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        border: Border.all(
                          color: kBlue1Color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      "assets/Fund/paytm.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Text(
                    "Paytm",
                    style: kMediumCaptionTextStyle.copyWith(
                      color: kBlue1Color,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
