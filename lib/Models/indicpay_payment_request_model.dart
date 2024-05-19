class IndicpayPaymentRequestModel {
  String message;
  String code;
  String status;
  PaymentData data;

  IndicpayPaymentRequestModel({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  // Factory constructor for creating a new IndicpayPaymentRequestModel instance from a map
  factory IndicpayPaymentRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return IndicpayPaymentRequestModel(
        message: '',
        code: '',
        status: '',
        data: PaymentData.empty(),
      );
    } else {
      return IndicpayPaymentRequestModel(
        message: json['message'] ?? '',
        code: json['code'] ?? 0,
        status: json['status'] ?? '',
        data: PaymentData.fromJson(json['data']),
      );
    }
  }

  // Method to convert an IndicpayPaymentRequestModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'data': data.toJson(),
    };
  }
}

class PaymentData {
  String status;
  String txnid;
  int amount;
  String upiUrl;

  PaymentData({
    required this.status,
    required this.txnid,
    required this.amount,
    required this.upiUrl,
  });

  // Factory constructor for creating a new PaymentData instance from a map
  factory PaymentData.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return PaymentData(
        status: '',
        txnid: '',
        amount: 0,
        upiUrl: '',
      );
    } else {
      return PaymentData(
        status: json['status'] ?? '',
        txnid: json['txnid'] ?? '',
        amount: json['amount'] ?? 0,
        upiUrl: json['upi_url'] ?? '',
      );
    }
  }

  // Method to convert a PaymentData instance to a map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'txnid': txnid,
      'amount': amount,
      'upi_url': upiUrl,
    };
  }

  // Factory constructor for creating an empty PaymentData instance
  factory PaymentData.empty() {
    return PaymentData(
      status: '',
      txnid: '',
      amount: 0,
      upiUrl: '',
    );
  }
}
