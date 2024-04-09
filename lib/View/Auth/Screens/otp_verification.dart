import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/View/Auth/Widgets/admin_help_button_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_decorator_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage(
      {super.key,
      required this.phoneNumber,
      required this.forgotPasswordcaller});
  final String phoneNumber;
  final String forgotPasswordcaller;
  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController otpController = TextEditingController();
  int _secondsLeft = 30; // Initial time in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Container(
        decoration: const BoxDecoration(gradient: kCustomGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 35),
                  alignment: Alignment.center,
                  height: 130,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/Logo/logo.png'))),
                ),
                InputDecoratorWidget(
                  title: "Enter OTP",
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Pinput(
                        defaultPinTheme: PinTheme(
                          textStyle:
                              kMediumTextStyle.copyWith(color: kWhiteColor),
                          height: 36,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: kWhiteColor),
                            borderRadius: kSmallBorderRadius,
                          ),
                        ),
                        controller: otpController,
                        length: 4,
                        onCompleted: (value) {
                          if (kDebugMode) {
                            print("submitted");
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: _secondsLeft == 0
                            ? Container()
                            : Text(
                                '$_secondsLeft seconds left',
                                style: kMediumCaptionTextStyle.copyWith(
                                    color: kWhiteColor),
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _secondsLeft == 0
                          ? Row(
                              children: [
                                Expanded(
                                  child: KLoginButton(
                                      gradient: kblueGradient,
                                      title: "Resend",
                                      onPressed: () async {
                                        setState(() {
                                          _secondsLeft = 30;
                                        });
                                        _startTimer();
                                        await HttpRequests.resendOtpRequest(
                                            mobile: widget.phoneNumber,
                                            context: context);
                                      }),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: KLoginButton(
                                    gradient: kblueGradient,
                                    title: "Verify",
                                    onPressed: () async {
                                      if (widget.forgotPasswordcaller ==
                                          "password") {
                                        await HttpRequests
                                            .verifyUserRequest(
                                          mobile: widget.phoneNumber,
                                          otp: otpController.text,
                                          caller: "Password",
                                          context: context,
                                        );
                                      } else if (widget.forgotPasswordcaller ==
                                          "pin") {
                                        await HttpRequests
                                            .verifyUserRequest(
                                          mobile: widget.phoneNumber,
                                          otp: otpController.text,
                                          caller: "Pin",
                                          context: context,
                                        );
                                      } else {
                                        await HttpRequests.verifyOtpRequest(
                                            mobile: widget.phoneNumber,
                                            otp: otpController.text,
                                            context: context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                      const AdminHelpButtonWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
