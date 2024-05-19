import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/app_details_model.dart';
import 'package:sm_matka/Models/payment_config_model.dart';
import 'package:sm_matka/Models/user_status_model.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/View/Splash/splash.dart';
import 'package:sm_matka/ViewModel/BlocCubits/add_fund_method_active_index_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_details_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/app_loading_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/payment_config_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/upi_payment_method_active_index_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_status_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppLoadingCubit(AppLoadingStates.initialLoading),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AppDetailsCubit(AppDetailsModel.fromJson({})),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              UserCubit(UserModel.fromJson(json: {}, token: "")),
        ),
        BlocProvider(
          create: (BuildContext context) => UserStatusCubit(
            UserStatusModel.fromJson(
              {},
            ),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => PaymentConfigCubit(
            PaymentConfigModel.fromJson(
              {},
            ),
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => ActiveFundMethodActiveIndexCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => UPIpaymentMethodActiveIndexCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //fixed font size
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child!,
          );
        },
        // home: const AddFundMethodPage(),
        home: const SplashScreen(),
      ),
    );
  }
}
