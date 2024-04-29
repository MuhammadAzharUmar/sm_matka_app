import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
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
      required this.caller,
      this.navigateTo});
  final String token;
  final String mobile;
  final String caller;
  final String? navigateTo;
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
                        keyboardType: widget.caller=="Pin"?TextInputType.number:TextInputType.text,
                      ),
                      InputTextFieldWidget(
                        isPassword: true,
                        controller: confirmPasswordController,
                        labelText: 'Enter Confirm ${widget.caller}',
                                                keyboardType: widget.caller=="Pin"?TextInputType.number:TextInputType.text,

                      ),
                      Row(
                        children: [
                          Expanded(
                            child: KLoginButton(
                              gradient: kblueGradient,
                              title: "Submit",
                              loadingstate:
                                  AppLoadingStates.changePasswordSubmit,
                              onPressed: () async {
                                if (passwordController.text.trim() != "" &&
                                    confirmPasswordController.text.trim() !=
                                        "") {
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    SnackBarMessage.centeredSnackbar(
                                        text: "${widget.caller} mismatch",
                                        context: context);
                                  } else {
                                    BlocProvider.of<AppLoadingCubit>(context)
                                        .updateAppLoadingState(AppLoadingStates
                                            .changePasswordSubmit);
                                    if (widget.caller == "Password") {
                                     
                                      await HttpRequests
                                          .forgotPasswordVerifyRequest(
                                        navigateTo: widget.navigateTo!,
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
                                    BlocProvider.of<AppLoadingCubit>(
                                            // ignore: use_build_context_synchronously
                                            context)
                                        .updateAppLoadingState(
                                            AppLoadingStates.initialLoading);
                                  }
                                } else {
                                  SnackBarMessage.centeredSnackbar(
                                      text: "Please Select Password",
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
