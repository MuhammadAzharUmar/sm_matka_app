// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/border_radius.dart';
import 'package:sm_matka/Utilities/colors.dart';
import 'package:sm_matka/Utilities/gradient.dart';
import 'package:sm_matka/Utilities/textstyles.dart';
import 'package:sm_matka/View/Auth/Widgets/klogin_button.dart';
import 'package:sm_matka/View/Profile/Widgets/edit_textfield_widget.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool isEdit = false;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
          backgroundColor: kBlue1Color,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            "Profile",
            style: kMediumTextStyle.copyWith(
                color: kWhiteColor, fontWeight: FontWeight.w700),
          )),
      body: BlocBuilder<UserCubit, UserModel>(builder: (context, user) {
        return BlocBuilder<UserStatusCubit, UserStatusModel>(
            builder: (context, userStatus) {
          //updating controller
          nameController = TextEditingController(text: user.data.username);
          mobileController = TextEditingController(text: user.data.mobile);
          emailController = TextEditingController(text: user.data.email);

          return SingleChildScrollView(
            child: Column(
              children: [
                isEdit
                    ? Container(
                        height: 50,
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                isEdit = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kBlue1Color,
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: kSmallBorderRadius),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              minimumSize: const Size(80, 30),
                              maximumSize: const Size(80, 30),
                            ),
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: kWhiteColor,
                              size: 16,
                            ),
                            label: Text(
                              "EDIT",
                              style: kSmallCaptionTextStyle.copyWith(
                                  color: kWhiteColor),
                            )),
                      ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: kblueGradient,
                    ),
                    child: Text(
                      user.data.username[0].toUpperCase(),
                      style: kMediumTextStyle.copyWith(
                        color: kWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  child: Text(
                    user.data.username,
                    style: kMediumCaptionTextStyle.copyWith(
                        color: kBlue1Color, fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: .5,
                  color: kBlue1Color,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: kSmallBorderRadius),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: kSmallBorderRadius,
                      ),
                      child: Column(
                        children: [
                          EditTextFieldWidget(
                            isReadOnly: !isEdit,
                            controller: nameController,
                            labelText: "Name",
                            hintText: user.data.username,
                          ),
                          EditTextFieldWidget(
                            isReadOnly: true,
                            controller: mobileController,
                            labelText: "Mobile",
                            hintText: user.data.mobile,
                          ),
                          EditTextFieldWidget(
                            isReadOnly: !isEdit,
                            controller: emailController,
                            labelText: "Email",
                            hintText: user.data.email,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                isEdit
                    ? Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 200,
                        child: Row(
                          children: [
                            Expanded(
                              child: KLoginButton(
                                title: "Submit Request",
                                loadingstate:
                                    AppLoadingStates.updateProfileButton,
                                onPressed: () async {
                                  setState(() {
                                    isloading = true;
                                  });
                                  try {
                                    BlocProvider.of<AppLoadingCubit>(context)
                                        .updateAppLoadingState(AppLoadingStates
                                            .updateProfileButton);
                                    await HttpRequests.updateProfileRequest(
                                      context: context,
                                      token: user.token,
                                      email: emailController.text,
                                      name: nameController.text,
                                    );
                                    Map<String, dynamic> userNewDate =
                                        await HttpRequests
                                            .getUserDetailsRequest(
                                      context: context,
                                      token: user.token,
                                    );

                                    UserCubit userCubit =
                                        context.read<UserCubit>();
                                    userCubit.updateAppUser(
                                      UserModel.fromJson(
                                        json: userNewDate,
                                        token: user.token,
                                      ),
                                    );
                                    BlocProvider.of<AppLoadingCubit>(context)
                                        .updateAppLoadingState(
                                            AppLoadingStates.initialLoading);

                                    // Map<String, dynamic> userNewstatus =
                                    //     await HttpRequests.getUserStatusRequest(
                                    //   context: context,
                                    //   token: user.token,
                                    // );
                                    // UserStatusCubit userStatusCubit =
                                    //     context.read<UserStatusCubit>();
                                    // userStatusCubit.updateAppUserStatus(
                                    //     UserStatusModel.fromJson(
                                    //         userNewstatus));
                                  } catch (e) {
                                    BlocProvider.of<AppLoadingCubit>(context)
                                        .updateAppLoadingState(
                                            AppLoadingStates.initialLoading);

                                    if (kDebugMode) {
                                      print(e);
                                    }
                                  }
                                  setState(() {
                                    isEdit = false;
                                  });
                                },
                                gradient: kblueGradient,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 0,
                      ),
              ],
            ),
          );
        });
      }),
    );
  }
}
