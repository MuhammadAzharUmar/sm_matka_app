import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/View/Auth/Widgets/admin_help_button_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_decorator_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController mobileController = TextEditingController();
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
                  title: "Forgot Password",
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                        keyboardType: TextInputType.number,
                        controller: mobileController,
                        labelText: 'Mobile',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: KLoginButton(gradient: kblueGradient,
                              title: "Submit",
                              onPressed: () async {
                                await HttpRequests.forgotPasswordRequest(
                                    mobile: mobileController.text, context: context);
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
