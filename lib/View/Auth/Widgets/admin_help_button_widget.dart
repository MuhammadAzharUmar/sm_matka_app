
import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';

class AdminHelpButtonWidget extends StatelessWidget {
  const AdminHelpButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 5),
          child: Text(
            "Need Help?",
            style: kSmallTextStyle.copyWith(
              color: kBlackColor,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: kBlackColor.withOpacity(.7),
                  foregroundColor: kblue1color,
                  elevation: 0,
                  minimumSize: const Size(130, 40),
                  maximumSize: const Size(130, 40),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: k2ndColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),),
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 10)),
              icon: Image.asset(
                "assets/General/whatsapp.png",
                width: 24,
                height: 24,
                alignment: Alignment.center,
              ),
              label: const Text("Admin")),
        )
      ],
    );
  }
}
