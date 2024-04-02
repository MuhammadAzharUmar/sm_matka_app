import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Screens/forgot_password.dart';
import 'package:sm_matka/View/Auth/Screens/signup.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:sm_matka/View/Auth/Widgets/admin_help_button_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_decorator_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblue1color,
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
                  title: "Login",
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: mobileController,
                        labelText: 'Mobile',
                      ),
                      InputTextFieldWidget(
                        controller: passwordController,
                        labelText: 'Enter Password',
                        isPassword: true,
                      ),
                      Container(
                        // color: kWhiteColor,
                        height: 30,
                        alignment: Alignment.topLeft,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordPage(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              minimumSize: const Size(double.maxFinite, 24),
                              maximumSize: const Size(double.maxFinite, 24),
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.centerLeft,
                              elevation: 0,
                            ),
                            child: Text(
                              "Forgot Password?",
                              style: kSmallTextStyle.copyWith(
                                color: kblue1color,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: KLoginButton(
                              gradient: kblueGradient,
                              title: "Login",
                              onPressed: () async {
                                await HttpRequests.loginRequest(
                                  mobile: mobileController.text.trim(),
                                  password: passwordController.text.trim(),
                                  context: context,
                                );
                              },
                            ),
                          ),
                          const Text("  \t\tor\t\t  "),
                          Expanded(
                            child: KLoginButton(
                                gradient: null,
                                title: "Signup",
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const SignupPage(),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10.0, bottom: 3),
                      //   child: Text(
                      //     "Don't have an account yet?",
                      //     style: kSmallTextStyle.copyWith(
                      //       color: kWhiteColor,
                      //     ),
                      //   ),
                      // ),
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
