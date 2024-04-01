
import 'package:flutter/material.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/View/Home/Widgets/fund_withdraw_chat_call_button_list.dart';

class FundWithdrawChatCallButtonWidget extends StatelessWidget {
  const FundWithdrawChatCallButtonWidget({
    super.key, required this.contactDetails,
  });
final ContactDetails contactDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: FundWithdrawChatCallButtonList.fundWithdrawChatCallButtonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 4),
        itemBuilder: (context, index) {
          return ElevatedButton.icon(
              onPressed:()async{
                await FundWithdrawChatCallButtonList.fundWithdrawChatCallButtonList[index]["onTap"](context,contactDetails);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue1Color.withOpacity(.9),
                  foregroundColor: kWhiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: kWhiteColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 10)),
              icon: Image.asset(
                FundWithdrawChatCallButtonList.fundWithdrawChatCallButtonList[index]["img"],
                width: 18,
                height: 18,
                alignment: Alignment.center,
              ),
              label: Text(FundWithdrawChatCallButtonList.fundWithdrawChatCallButtonList[index]["title"]));
        },
      ),
    );
  }
}
