import 'package:flutter/material.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Screens/login.dart';
import 'package:sm_matka/View/Auth/Widgets/admin_help_button_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_decorator_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/input_textfield_widget.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                          image: AssetImage('assets/Logo/logo.png'))),
                ),
                InputDecoratorWidget(
                  title: "Sign Up",
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(
                        controller: nameController,
                        labelText: 'Enter Your Name',
                      ),
                      InputTextFieldWidget(
                        controller: mobileController,
                        labelText: 'Mobile',
                      ),
                      InputTextFieldWidget(
                        controller: passwordController,
                        labelText: 'Enter Password',
                        isPassword: true,
                      ),
                      InputTextFieldWidget(
                        controller: pinController,
                        labelText: 'Enter Security Pin',
                        isPassword: true,
                      ),
                      KLoginButton(
                        title: "Signup",
                        onPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 3),
                        child: Text(
                          "Already have an account?",
                          style: kSmallTextStyle.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                      KLoginButton(
                          title: "Login",
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          })
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
