// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sm_matka/Models/payment_config_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Funds/Widgets/AddFundWidget/ad_video_player.dart';
import 'package:sm_matka/View/Funds/Widgets/add_fund_notice_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/payment_config_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/ViewModel/pick_image_from_gallery.dart';
import 'package:sm_matka/ViewModel/recognize_text_from_image.dart';

class ScanPayScreen extends StatefulWidget {
  const ScanPayScreen({
    super.key,
    required this.points,
  });
  final String points;

  @override
  State<ScanPayScreen> createState() => _ScanPayScreenState();
}

class _ScanPayScreenState extends State<ScanPayScreen> {
  TextEditingController transctionIdController = TextEditingController();
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(builder: (context, currentUser) {
      return BlocBuilder<PaymentConfigCubit, PaymentConfigModel>(
          builder: (context, paymentConfigModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AddFundNoticeWidget(
                heading: "QR Code Notice",
                addfundNotice: paymentConfigModel
                    .data.availableMethodsDetails.qrCode.notice,
              ),
            ),
            SizedBox(
              height: 68,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/General/diamond.png",
                    width: 46,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.points,
                        style: kSmallTextStyle.copyWith(
                          color: kBlue1Color,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "Points",
                        style: kSmallTextStyle.copyWith(
                          color: kBlue1Color,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 180,
              width: 180,
              child:
                  //  Image.network(
                  //   paymentConfigModel.data.availableMethodsDetails.qrCode.qrImage,
                  //   width: 200,
                  //   fit: BoxFit.contain,
                  //   errorBuilder: (context, error, stackTrace) {
                  //     // print(paymentConfigModel.data.availableMethodsDetails.qrCode.qrImage,);
                  //     return  Container(
                  //       height: 180,
                  //       width: 180,
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(border: Border.all(color: kBlue1Color,width: 1),),
                  //       child:const Text("QR Code ..."));
                  //   },
                  // ),
                  QrImageView(
                data:
                    'upi://pay?pa=${paymentConfigModel.data.availableMethodsDetails.qrCode.qrUpiId}&am=${widget.points}',
                version: QrVersions.auto,
                size: 180.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  paymentConfigModel
                      .data.availableMethodsDetails.qrCode.qrUpiId,
                  style: kMediumTextStyle.copyWith(
                    color: kBlue1Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                      text: paymentConfigModel
                          .data.availableMethodsDetails.qrCode.qrUpiId,
                    ));
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: kBlue1Color,
                  ),
                ),
              ],
            ),
            Text(
              "Please pick the screenshot to upload",
              style: kSmallCaptionTextStyle.copyWith(
                color: kBlue1Color,
                fontWeight: FontWeight.w400,
              ),
            ),
            imagePath != ""
                ? Container(
                    height: 100,
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: const BoxDecoration(
                      gradient: kblueGradient,
                      borderRadius: kMediumBorderRadius,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
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
                                      "Screenshot Preview",
                                      style: kMediumTextStyle.copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  body: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      borderRadius: kSmallBorderRadius,
                                      color: kWhiteColor,
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(
                                            imagePath,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  floatingActionButton:
                                      FloatingActionButton(onPressed: () {
                                    setState(() {
                                      imagePath = "";
                                      transctionIdController.clear();
                                    });
                                    Navigator.of(context).pop();
                                    
                                  },
                                  backgroundColor: k2ndColor,
                                  child: Text("Retake",style: kMediumCaptionTextStyle.copyWith(color: kBlue1Color,),),
                                  ),
                                );
                              },
                            ));
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: kSmallBorderRadius,
                              color: k2ndColor,
                              image: DecorationImage(
                                image: FileImage(
                                  File(
                                    imagePath,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Screenshot Preview",
                                style: kMediumTextStyle.copyWith(
                                  color: k2ndColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                imagePath.split("/").last,
                                style: kSmallTextStyle.copyWith(
                                  color: k2ndColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 70,
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                imagePath = "";
                                 transctionIdController.clear();
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: k2ndColor, width: 1),
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Text(
                                "Retake",
                                style: kMediumCaptionTextStyle.copyWith(
                                  color: k2ndColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):
            BlocBuilder<AppLoadingCubit, AppLoadingStates>(
                builder: (context, loadingState) {
              return ElevatedButton.icon(
                onPressed: () async {
                  context.read<AppLoadingCubit>().updateAppLoadingState(
                      AppLoadingStates.uploadScreenshotLoading);
                  imagePath = await PickImageFromGallery.pickPhotoFromGallery();
                  if (imagePath != "") {
                    String extractedText =
                        await RecognizeTextFromImage.readTextFromImage(
                            imagePath: imagePath);
                    List<String> extractedId =
                        RecognizeTextFromImage.extractTransactionID(
                            extractedText);
                    if (extractedId.isNotEmpty) {
                    final screenshotPicked = await  showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            backgroundColor: kWhiteColor,
                            content: Container(
                              decoration: const BoxDecoration(
                                borderRadius: kLargeBorderRadius,
                                color: kWhiteColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 16,
                              ),
                              // height: 200,
                              width: double
                                  .maxFinite, // Adjust the height as needed
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Choose Transcation ID",
                                      style: kMediumTextStyle.copyWith(
                                        color: kBlue1Color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: 300,
                                      child: Image.file(File(imagePath)),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      itemCount: extractedId.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(
                                            color: k2ndColor,
                                            borderRadius: kMediumBorderRadius,
                                            border: Border.all(
                                              color: kBlue1Color,
                                              width: .5,
                                            ),
                                          ),
                                          child: ListTile(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: kMediumBorderRadius,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 2),
                                            tileColor: k2ndColor,
                                            dense: true,
                                            onTap: () {
                                              transctionIdController.text =
                                                  extractedId[index];
                                              Navigator.of(context).pop(true);
                                            },
                                            title: Text(
                                              "#ID: ${extractedId[index]}",
                                              style: kMediumCaptionTextStyle
                                                  .copyWith(
                                                color: kBlue1Color,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            trailing: const Icon(
                                              Icons.copy,
                                              color: kBlue1Color,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        imagePath == "";
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text(
                                        'Close',
                                        style: kMediumTextStyle.copyWith(
                                          color: kBlue1Color,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      );
                      if (screenshotPicked != null && screenshotPicked) {
                               
                              setState(() {});
                            }
                    }
                  }
                  context
                      .read<AppLoadingCubit>()
                      .updateAppLoadingState(AppLoadingStates.initialLoading);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: k2ndColor,
                    foregroundColor: kBlue1Color,
                    minimumSize: const Size(250, 36),
                    maximumSize: const Size(250, 36),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 0)),
                icon: loadingState == AppLoadingStates.uploadScreenshotLoading
                    ? Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: kBlue1Color,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Icons.photo,
                        color: kBlue1Color,
                        size: 24,
                      ),
                label: Text(
                  loadingState == AppLoadingStates.uploadScreenshotLoading
                      ? "uploading..."
                      : "Upload Screenshot",
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                gradient: kblueGradient,
                borderRadius: kLargeBorderRadius,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputTextFieldWidget(
                    controller: transctionIdController,
                    labelText: "Enter Transcation ID",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: KLoginButton(
                            title: "Submit",
                            loadingstate:
                                AppLoadingStates.paymentSubmitButtonLoading,
                            gradient: kblueGradient,
                            onPressed: () async {
                              if (imagePath == "") {
                                return SnackBarMessage.centeredSnackbar(
                                  text: "Please upload screenshot",
                                  context: context,
                                );
                              }
                              if (transctionIdController.text != "" &&
                                  imagePath != "" &&
                                  widget.points != "") {
                                context
                                    .read<AppLoadingCubit>()
                                    .updateAppLoadingState(AppLoadingStates
                                        .paymentSubmitButtonLoading);
                                try {
                                  await HttpRequests.payemntReceiveRequest(
                                    context: context,
                                    token: currentUser.token,
                                    amount: widget.points,
                                    authorization: "",
                                    status: "success",
                                    method: "qrcode",
                                    transcationId:
                                        transctionIdController.text.trim(),
                                    methodDetails: "",
                                    screenshot: imagePath,
                                  );
                                  transctionIdController.clear();
                                  imagePath="";
                                } catch (e) {
                                  SnackBarMessage.centeredSnackbar(
                                    text: "unknow error try again later",
                                    context: context,
                                  );
                                }
                                context
                                    .read<AppLoadingCubit>()
                                    .updateAppLoadingState(
                                        AppLoadingStates.initialLoading);
                              } else {
                                return SnackBarMessage.centeredSnackbar(
                                  text: "Please enter transcation ID",
                                  context: context,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              width: double.maxFinite,
              decoration: const BoxDecoration(color: kBlackColor),
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: VideoContainer(
                videoUrl: paymentConfigModel
                    .data.availableMethodsDetails.qrCode.video,
              ),
            ),
          ],
        );
      });
    });
  }
}
