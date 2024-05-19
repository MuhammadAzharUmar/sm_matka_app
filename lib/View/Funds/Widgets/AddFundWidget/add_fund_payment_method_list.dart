import 'package:flutter/material.dart';
import 'package:upi_india/upi_app.dart';

class AddFundPaymentMethodList {
  static List<Map<String, dynamic>> addFundPaymentMethodList = [
    {
      "img": "assets/Fund/upi.png",
      "title": "UPI",
    },
    {
      "img": "assets/Fund/scanner.png",
      "title": "SCAN",
    },
    {
      "img": "assets/Fund/bank.png",
      "title": "BANK",
    },
    {
      "img": "assets/Fund/upi.png",
      "title": "PAY_SANTS",
    },
    {
      "img": "assets/Fund/upi.png",
      "title": "INDICPAY",
    },
  ];
  static Map<String, dynamic> titleWidgetMappingMap = {
    "UPI": (Widget pageWidget) {
      return pageWidget;
    },
    "SCAN": (Widget pageWidget) {
      return pageWidget;
    },
    "BANK": (Widget pageWidget) {
      return pageWidget;
    },
    "PAY_SANTS": (Widget pageWidget) {
      return pageWidget;
    },
    "INDICPAY": (Widget pageWidget) {
      return pageWidget;
    },
  };

  static List<Map<String, dynamic>> upiPaymentMethodList = [
    {
      "img": "assets/Fund/gpay.png",
      "title": "Google Pay",
      "app": UpiApp.googlePay,
      "method": "upi",
      // "method": "gpay",
    },
    {
      "img": "assets/Fund/phonepe.png",
      "title": "Phone Pay",
      "app": UpiApp.phonePe,
      // "method": "phonepe",
      "method": "upi",
    },
    {
      "img": "assets/Fund/paytm.png",
      "title": "Paytm",
      // "method": "paytm",
      "method": "upi",
      "app": UpiApp.paytm,
    },
  ];
}
