
// import 'package:flutter/material.dart';
// import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
// import 'package:flutter_pay_upi/model/upi_app_model.dart';
// import 'package:flutter_pay_upi/model/upi_response.dart';
// import 'package:sm_matka/Utilities/snackbar_messages.dart';

// class FlutterPayUpiFunction {
//   static void initiatePayment(String app, String receiverName, String receiverUpiId,
//       String amount,BuildContext context) async {
//     // Generate a unique transaction ID using current timestamp
//     String transactionId = DateTime.now().millisecondsSinceEpoch.toString();
//     List<UpiApp> upiInstalledApp =
//         await FlutterPayUpiManager.getListOfAndroidUpiApps();
//     bool installed =
//         upiInstalledApp.any((element) => element.name!.contains(app));
//     if (installed) {
//       // Perform payment using the selected UPI app
//       FlutterPayUpiManager.startPayment(
//         paymentApp: app,
//         payeeVpa: receiverUpiId,
//         payeeName: receiverName,
//         transactionId: transactionId,
//         payeeMerchantCode: "",
//         description: "test payment",
//         amount: amount.toString(),
//         response: (upiResponse, amount) {
//            showTransactionDetailsDialog(upiResponse, amount,context);
//         },
//         error: (error) {
//           showRoundedDialog(context, error.toString());
//         },
//       );
//     } else {
//       // ignore: use_build_context_synchronously
//       SnackBarMessage.centeredSnackbar(text: "App not found", context: context);
//     }
//   }

//   static void showRoundedDialog(BuildContext context, String? message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           child: Container(
//             padding:const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                const Text(
//                   'Error',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Text('$message'),
//                const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context); // Close the dialog
//                   },
//                   child:const Text('Close'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static void showTransactionDetailsDialog(
//       UpiResponse upiRequestParams, String amount,BuildContext context) {
        
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title:const Text('Transaction Details'),
//           children: [
//             _buildDetailRow('Txn ID', upiRequestParams.transactionID ?? "N/A"),
//             _buildDetailRow(
//                 'Response Code', upiRequestParams.responseCode ?? "N/A"),
//             _buildDetailRow('Approval Reference No',
//                 upiRequestParams.approvalReferenceNo ?? "N/A"),
//             _buildDetailRow(
//                 'Txn Ref Id', upiRequestParams.transactionReferenceId ?? "N/A"),
//             _buildDetailRow('Status', upiRequestParams.status ?? "N/A"),
//             _buildDetailRow('Amount', amount),
//           ],
//         );
//       },
//     );
//   }
//   static Widget _buildDetailRow(String key, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//       child: Row(
//         children: [
//           Text('$key:', style:const TextStyle(fontWeight: FontWeight.w800)),
//           const SizedBox(width: 8.0),
//           Flexible(
//             child: Text(
//               value,
//               overflow: TextOverflow.visible,
//               softWrap: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
