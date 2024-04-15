import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/View/Auth/Widgets/admin_help_button_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_decorator_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage(
      {super.key,
      required this.token,
      required this.mobile,
      required this.caller});
  final String token;
  final String mobile;
  final String caller;
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                  title: "Change ${widget.caller}",
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                        isPassword: true,
                        controller: passwordController,
                        labelText: 'Enter ${widget.caller}',
                      ),
                      InputTextFieldWidget(
                        isPassword: true,
                        controller: confirmPasswordController,
                        labelText: 'Enter Confirm ${widget.caller}',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: KLoginButton(gradient: kblueGradient,
                              title: "Submit",
                              onPressed: () async {
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  SnackBarMessage.centeredSnackbar(
                                      text: "${widget.caller} mismatch",
                                      context: context);
                                } else {
                                  if (widget.caller == "Password") {
                                    await HttpRequests
                                        .forgotPasswordVerifyRequest(
                                      mobile: widget.mobile,
                                      token: widget.token,
                                      password: passwordController.text,
                                      context: context,
                                    );
                                  } else {
                                    await HttpRequests.createPinRequest(
                                      mobile: widget.mobile,
                                      token: widget.token,
                                      pin: passwordController.text,
                                      context: context,
                                    );
                                  }
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
