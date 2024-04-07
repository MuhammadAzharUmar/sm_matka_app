import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
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
                    strokeWidth: 1,
                  ),
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    AddFundNoticeWidget(
                      addfundNotice: appDetailsModel.data.appNotice,
                      caller: "appNotice",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AddFundNoticeWidget(
                      addfundNotice: appDetailsModel.data.addFundNotice,
                      caller: "add",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AddFundNoticeWidget(
                      addfundNotice: appDetailsModel.data.withdrawNotice,
                      caller: "withdraw",
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
