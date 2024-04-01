import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Settings/Widgets/launch_custom_urls.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  AppDetailsModel appDetailsModel = AppDetailsModel.fromJson({});
  @override
  void initState() {
    appDetailsModel = context.read<AppDetailsCubit>().state;
    super.initState();
    contactDetails = [
      {
        "title": "Call Us",
        "img": "assets/General/call.png",
        "contact": appDetailsModel.data.contactDetails.mobileNo1,
        "onTap": (BuildContext context) async {
          await LaunchCustomUrls.launchURL(
            url: 'tel:${appDetailsModel.data.contactDetails.mobileNo1}',
          );
        },
      },
      {
        "title": "Call Us",
        "img": "assets/General/call.png",
        "contact": appDetailsModel.data.contactDetails.mobileNo2,
        "onTap": (BuildContext context) async {
          await LaunchCustomUrls.launchURL(
            url: 'tel:${appDetailsModel.data.contactDetails.mobileNo2}',
          );
        },
      },
      {
        "title": "Chat Us",
        "img": "assets/General/whatsapp.png",
        "contact": appDetailsModel.data.contactDetails.whatsappNo,
        "onTap": (BuildContext context) async {
          await LaunchCustomUrls.launchURL(
            url:
                'https://wa.me/${appDetailsModel.data.contactDetails.whatsappNo}',
          );
        },
      },
      {
        "title": "Mail Us",
        "img": "assets/General/email.png",
        "contact": appDetailsModel.data.contactDetails.email1,
        "onTap": (BuildContext context) async {
          await LaunchCustomUrls.launchURL(
            url:
                'mailto:${appDetailsModel.data.contactDetails.email1}',
          );
        },
      },
      {
        "title": "Telegram",
        "img": "assets/General/telegram.png",
        "contact": appDetailsModel.data.contactDetails.telegramNo,
        "onTap": (BuildContext context) async {
          await LaunchCustomUrls.launchURL(
            url:
                'https://telegram.me/${appDetailsModel.data.contactDetails.telegramNo}',
          );
        },
      },
      {
        "title": "Withdraw Proof",
        "img": "assets/General/withdraw.png",
        "contact": appDetailsModel.data.contactDetails.withdrawProof,
        "onTap": (BuildContext context) async {
          await LaunchCustomUrls.launchURL(
            url:
                appDetailsModel.data.contactDetails.withdrawProof,
          );
        },
      },
    ];
  }

  List<Map<String, dynamic>> contactDetails = [];

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
          "Contact Us",
          style: kMediumTextStyle.copyWith(
              color: kWhiteColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.builder(
        itemCount: contactDetails.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                  borderRadius: kMediumBorderRadius),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: const BoxDecoration(
                    color: kWhiteColor, borderRadius: kMediumBorderRadius),
                child: ListTile(
                  onTap: () async {
                    await contactDetails[index]["onTap"](context);
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  horizontalTitleGap: 20,
                  leading: Image.asset(
                    contactDetails[index]["img"],
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    contactDetails[index]["title"],
                    style: kMediumTextStyle.copyWith(
                      color: kBlue3Color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    contactDetails[index]["contact"],
                    style: kSmallCaptionTextStyle.copyWith(
                      color: kBlue3Color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: kBlue1Color,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
