import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Screens/forgot_pin.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/View/Auth/Widgets/admin_help_button_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_decorator_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';

class LoginPin extends StatefulWidget {
  const LoginPin({super.key, required this.token});
  final String token;
  @override
  State<LoginPin> createState() => _LoginPinState();
}

class _LoginPinState extends State<LoginPin> {
  final TextEditingController pinController = TextEditingController();

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
                      image: AssetImage('assets/Logo/logo.png'),
                    ),
                  ),
                ),
                InputDecoratorWidget(
                  title: "Enter Pin Code",
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Pinput(
                        obscureText: true,
                        obscuringWidget: Container(
                          alignment: Alignment.center,
                          decoration:const BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: kSmallBorderRadius,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: kBlue1Color,
                            size: 14,
                          ),
                        ),
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
                        controller: pinController,
                        length: 4,
                        onCompleted: (value) {
                          if (kDebugMode) {
                            print("submitted");
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: KLoginButton(
                              gradient: kblueGradient,
                              title: "Proceed",
                              onPressed: () async {
                                await HttpRequests.loginPinRequest(
                                    token: widget.token,
                                    pin: pinController.text,
                                    context: context);
                              },
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text("or"),
                      ),
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        height: 46,
                        child: InkWell(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPinPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Reset Pin",
                            style: kMediumTextStyle.copyWith(
                              color: k2ndColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const AdminHelpButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
