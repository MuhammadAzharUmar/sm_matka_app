// ignore_for_file: use_build_context_synchronously, type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_matka/Models/usermodel.dart';
import 'package:sm_matka/Utilities/snackbar_messages.dart';
import 'package:sm_matka/ViewModel/BlocCubits/user_cubit.dart';
import 'package:sm_matka/ViewModel/http_requests.dart';
import 'package:upi_india/upi_india.dart';
import 'package:uuid/uuid.dart';

class UpiPaymentFunction {
  static upiPaymentFunction({
    required UpiApp app,
    required double amount,
    required BuildContext context,
    required String receiverName,
    required String receiverUpiId,
    required String method,
    required String upiName,
    required String upiId,
    required String type,
    required String remark,
  }) async {
    // UpiApp app = UpiApp.paytm;
    // Generate a unique transaction ID using UUID
    String transactionId = const Uuid().v4();

    // Initialize UPI India
    UpiIndia upi = UpiIndia();

    // Define transaction details
    try {
      UpiResponse response = await upi.startTransaction(
        app: app,
        receiverUpiId: upiId,
        receiverName: upiName,
        transactionRefId: transactionId,
        transactionNote: remark,
        amount: amount, // Amount in INR
      );
      String msg = await handleTheResponse(
        method: method,
        response: response,
        context: context,
        methodDetails:type,
        amount: amount.toString(),
        transcationId: transactionId,
      );
      SnackBarMessage.centeredSnackbar(text: msg, context: context);
    } catch (e) {
      String errorMsg = upiErrorHandler(e.runtimeType);
      SnackBarMessage.centeredSnackbar(text: errorMsg, context: context);
    }
  }

  static String upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  static Future<String> handleTheResponse({
    required UpiResponse response,
    required BuildContext context,
    required String amount,
    required String method,
    required String methodDetails,
    required String transcationId,
  }) async {
    // Handle the response
    if (response.status == UpiPaymentStatus.SUCCESS) {
      // print('Payment successful!');
      // call payment receive api
      try {
        UserModel currentUser = context.read<UserCubit>().state;
        await HttpRequests.payemntReceiveRequest(
          context: context,
          token: currentUser.token,
          amount: amount,
          authorization: "",
          method: method,
          status: 'success',
          methodDetails: methodDetails,
          screenshot: "",
          transcationId: transcationId,
        );
        return 'Payment successful!';
      } catch (e) {
        return "error while uploading data";
      }

      // Handle success scenario
    } else if (response.status == UpiPaymentStatus.FAILURE) {
      // print('Payment failed: ${response.responseCode}');
      return 'Payment Payment failed: ${response.responseCode}!';
      // Handle failure scenario
    } else if (response.status == UpiPaymentStatus.SUBMITTED) {
      // print('payment submitted');
      return 'Payment submitted!';
      // Handle scenario where app is not installed
    } else if (response.status == UpiPaymentStatus.OTHER) {
      // print(response.status);
      return response.status.toString();
    } else {
      // print('Payment cancelled by user');
      return 'Unknown Error';
    }
  }
}
