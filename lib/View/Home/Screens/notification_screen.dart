// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
import 'package:sm_matka/View/Home/Widgets/home_init_function.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      setState(() {
        isloading = true;
      });
      try {
        await HomeInitFunction.refreshAppDetailsFunction(context: context);

        UserModel currentUser = context.read<UserCubit>().state;
        final jsonData = await HttpRequests.readNotificationRequest(
            context: context, token: currentUser.token);

        if (kDebugMode) {
          print(jsonData);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      setState(() {
        isloading = false;
      });
    });
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDetailsCubit, AppDetailsModel>(
        builder: (context, appDetailsModel) {
      return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(true);
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
            "Notice",
            style: kMediumTextStyle.copyWith(
                color: kWhiteColor, fontWeight: FontWeight.w700),
          ),
        ),
        body: isloading
            ? Center(
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: kBlue1Color,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: RefreshIndicator(
                  onRefresh: ()async {
                    await HomeInitFunction.refreshAppDetailsFunction(context: context);
                    
                  },
                  child: SingleChildScrollView(
                    physics:const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        AddFundNoticeWidget(
                          addfundNotice: appDetailsModel.data.appNotice,
                          heading: "App Notice",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AddFundNoticeWidget(
                          addfundNotice: appDetailsModel.data.addFundNotice,
                          heading: "Add Fund Notice",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AddFundNoticeWidget(
                          addfundNotice: appDetailsModel.data.withdrawNotice,
                          heading: "Withdraw Fund Notice",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
