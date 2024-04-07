import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Funds/Widgets/fundlist.dart';

class Funds extends StatefulWidget {
  const Funds({super.key});

  @override
  State<Funds> createState() => _FundsState();
}

class _FundsState extends State<Funds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
          foregroundColor: kWhiteColor,
          backgroundColor: kBlue1Color,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Funds",
            style: kMediumTextStyle.copyWith(
                color: kWhiteColor, fontWeight: FontWeight.w700),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                itemCount: FundList.fundList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 140),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await FundList.fundList[index]["onTap"](context);
                    },
                    child: Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                          borderRadius: kSmallBorderRadius),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: kSmallBorderRadius,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 80,
                                    width: 80,
                                    child: Lottie.asset(
                                      "assets/General/animation.json",
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      FundList.fundList[index]["img"],
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 5,
                              thickness: .5,
                              color: kBlue1Color,
                              indent: 5,
                              endIndent: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FundList.fundList[index]["title"],
                                    style: kMediumCaptionTextStyle.copyWith(
                                      color: kBlue1Color,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 10,
                                    color: kBlue1Color,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
