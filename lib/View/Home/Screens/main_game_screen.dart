import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen(
      {super.key,
      required this.title,
      required this.data,
      required this.gameList});
  final String title;
  final Map<String, dynamic> data;
  final List<Map<String, dynamic>> gameList;
  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: kWhiteColor,
            )),
        backgroundColor: kBlue1Color,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: kMediumTextStyle.copyWith(
              color: kWhiteColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // GridView.builder(
                //   itemCount: widget.gameList.length,
                //   shrinkWrap: true,

                //   physics: const NeverScrollableScrollPhysics(),
                //   gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(

                //       crossAxisCount: 2,
                //         // widget.gameList.length<5?2:  MediaQuery.of(context).size.width * 1 >= 380 ? 3 : 2,
                //       crossAxisSpacing: 10,
                //       mainAxisSpacing: 10,
                //       mainAxisExtent: 140),
                //   itemBuilder: (context, index) {

                //     return Container(
                //       width: double.maxFinite,
                //       alignment: Alignment.center,
                //       child: InkWell(
                //         onTap: () async {
                //           await widget.gameList[index]
                //               ["onTap"](context, widget.data);
                //         },
                //         child: Card(
                //           elevation: 2,
                //           shape: const RoundedRectangleBorder(
                //               borderRadius: kSmallBorderRadius),
                //           child: Container(
                //             decoration: const BoxDecoration(
                //               color: kWhiteColor,
                //               borderRadius: kSmallBorderRadius,
                //             ),
                //             child: Column(
                //               children: [
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   height: 110,
                //                   width: 150,
                //                   child: Stack(
                //                     children: [
                //                       Center(
                //                         child: Container(
                //                           alignment: Alignment.center,
                //                           height: 110,
                //                           width: 110,
                //                           child: Lottie.asset(
                //                             "assets/General/animation.json",
                //                             width: 110,
                //                             height: 110,
                //                             fit: BoxFit.cover,
                //                           ),
                //                         ),
                //                       ),
                //                       Center(
                //                         child: Container(
                //                           height: 110,
                //                           width: 110,
                //                           alignment: Alignment.center,
                //                           child: Image.asset(
                //                             widget.gameList[index]["img"],
                //                             width: 95,
                //                             height: 95,
                //                             fit: BoxFit.contain,
                //                           ),
                //                         ),
                //                       ),
                //                        Container(width: 150,
                //                       //  height: 50,
                //                       //  color: kBlue1Color,
                //                        alignment: Alignment.topRight,
                //                         padding:const EdgeInsets.all(5.0),
                //                         child:const Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.end,
                //                           children: [
                //                             Icon(
                //                               Icons.arrow_forward_ios_rounded,
                //                               size: 10,
                //                               color: kBlue1Color,
                //                             ),
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                Center(
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    alignment: WrapAlignment
                        .center, // Change alignment property as needed
                    children: List.generate(widget.gameList.length, (index) {
                      // ignore: avoid_unnecessary_containers
                      return Container(
                        // width:index==widget.gameList.length-1? double.maxFinite:MediaQuery.of(context).size.width*.5,
                        // alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            await widget.gameList[index]
                                ["onTap"](context, widget.data);
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
                                  Container(
                                    alignment: Alignment.center,
                                    height: 130,
                                    width: 150,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 110,
                                            width: 110,
                                            child: Lottie.asset(
                                              "assets/General/animation.json",
                                              width: 110,
                                              height: 110,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            height: 110,
                                            width: 110,
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              widget.gameList[index]["img"],
                                              width: 95,
                                              height: 95,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                         Container(width: 150,
                                        //  height: 50,
                                        //  color: kBlue1Color,
                                         alignment: Alignment.topRight,
                                          padding:const EdgeInsets.all(5.0),
                                          child:const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
