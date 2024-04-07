import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class WalletStatementWidget extends StatefulWidget {
  const WalletStatementWidget({
    super.key,
  });

  @override
  State<WalletStatementWidget> createState() =>
      _WalletStatementWidgetState();
}

class _WalletStatementWidgetState extends State<WalletStatementWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
      return FutureBuilder<Map<String, dynamic>>(
        future: HttpRequests.walletStatementRequest(
            context: context, token: user.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                child: const CircularProgressIndicator(
                  color: kBlue1Color,
                  strokeWidth: 3,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: InkWell(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 100,
                    child: Text(
                      "Try again",
                      style: kMediumCaptionTextStyle.copyWith(
                          color: kBlue1Color, fontWeight: FontWeight.w600),
                    )),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!["data"]["statement"].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: kMediumBorderRadius),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: const BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: kMediumBorderRadius),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!["data"]["statement"][index]
                                ["trans_msg"],
                            style: kMediumTextStyle.copyWith(
                              color: kBlue3Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            color: kBlue1Color,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!["data"]["statement"][index]
                                    ["points"],
                                style: kSmallCaptionTextStyle.copyWith(
                                  color: kBlue1Color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                snapshot.data!["data"]["statement"][index]
                                    ["trans_status"],
                                style: kSmallCaptionTextStyle.copyWith(
                                  color: snapshot.data!["data"]["statement"]
                                              [index]["trans_status"] ==
                                          "Successful"
                                      ? Colors.green
                                      : snapshot.data!["data"]["statement"]
                                                  [index]["trans_status"] ==
                                              "Rejected"
                                          ? Colors.red
                                          : kBlue1Color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            width: double.maxFinite,
                            child: Text(
                              snapshot.data!["data"]["statement"][index]
                                  ["created_at"],
                              style: kSmallCaptionTextStyle.copyWith(
                                color: kBlackColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      );
    });
  }
}
