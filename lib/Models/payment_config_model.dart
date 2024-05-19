class PaymentConfigModel {
  String message;
  String code;
  String status;
  Data data;

  PaymentConfigModel(
      {required this.message,
      required this.code,
      required this.status,
      required this.data});

  factory PaymentConfigModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return PaymentConfigModel(
        message: '',
        code: '',
        status: '',
        data: Data.fromJson({}),
      );
    } else {
      return PaymentConfigModel(
        message: json['message'],
        code: json['code'],
        status: json['status'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}

class Data {
  String supportNumber;
  AvailableMethods availableMethods;
  AvailableMethodsDetails availableMethodsDetails;

  Data({
    required this.supportNumber,
    required this.availableMethods,
    required this.availableMethodsDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return Data(
        supportNumber: '',
        availableMethods: AvailableMethods.fromJson({}),
        availableMethodsDetails: AvailableMethodsDetails.fromJson({}),
      );
    } else {
      return Data(
        supportNumber: json['support_number'],
        availableMethods: AvailableMethods.fromJson(json['available_methods']),
        availableMethodsDetails:
            AvailableMethodsDetails.fromJson(json['available_methods_details']),
      );
    }
  }
}

class AvailableMethods {
  bool bankAccount;
  bool upi;
  bool qrCode;
  List<PaymentGateway> paymentGateway;

  AvailableMethods(
      {required this.bankAccount,
      required this.upi,
      required this.qrCode,
      required this.paymentGateway});

  factory AvailableMethods.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return AvailableMethods(
        bankAccount: false,
        upi: false,
        qrCode: false,
        paymentGateway: [],
      );
    } else {
      var list = json['payment_gateway'] as List<dynamic>;
      List<PaymentGateway> paymentGatewayList = list
          .map((e) => PaymentGateway.fromJson(e as Map<String, dynamic>))
          .toList();

      return AvailableMethods(
        bankAccount: json['bank_account'] ?? false,
        upi: json['upi'] ?? false,
        qrCode: json['qr_code'] ?? false,
        paymentGateway: paymentGatewayList,
      );
    }
  }
}

class PaymentGateway {
  String type;
  String video;
  String notice;

  PaymentGateway(
      {required this.type, required this.video, required this.notice});

  factory PaymentGateway.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return PaymentGateway(
        type: '',
        video: '',
        notice: '',
      );
    } else {
      return PaymentGateway(
        type: json['type'],
        video: json['video'],
        notice: json['notice'],
      );
    }
  }
}

class AvailableMethodsDetails {
  String defaultMethod;
  String upiLimit;
  String amountConfiguration;
  Upi upi;
  SmallAndLargeAmountUpi smallAmountUpi;
  SmallAndLargeAmountUpi largeAmountUpi;
  BankAccount bankAccount;
  QrCode qrCode;

  AvailableMethodsDetails({
    required this.defaultMethod,
    required this.upiLimit,
    required this.amountConfiguration,
    required this.upi,
    required this.smallAmountUpi,
    required this.largeAmountUpi,
    required this.bankAccount,
    required this.qrCode,
  });

  factory AvailableMethodsDetails.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return AvailableMethodsDetails(
        defaultMethod: '',
        upiLimit: '',
        amountConfiguration: '',
        upi: Upi.fromJson({}),
        smallAmountUpi: SmallAndLargeAmountUpi.fromJson({}),
        largeAmountUpi: SmallAndLargeAmountUpi.fromJson({}),
        bankAccount: BankAccount.fromJson({}),
        qrCode: QrCode.fromJson({}),
      );
    } else {
      return AvailableMethodsDetails(
        defaultMethod: json['default_method'],
        upiLimit: json['upi_limit'],
        amountConfiguration: json['amount_configuration'],
        upi: Upi.fromJson(json['upi']),
        smallAmountUpi:
            SmallAndLargeAmountUpi.fromJson(json['small_amount_upi']),
        largeAmountUpi:
            SmallAndLargeAmountUpi.fromJson(json['large_amount_upi']),
        bankAccount: BankAccount.fromJson(json['bank_account']),
        qrCode: QrCode.fromJson(json['qr_code']),
      );
    }
  }
}

class Upi {
  String video;
  String notice;

  Upi({required this.video, required this.notice});

  factory Upi.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return Upi(
        video: '',
        notice: '',
      );
    } else {
      return Upi(
        video: json['video'],
        notice: json['notice'],
      );
    }
  }
}

class SmallAndLargeAmountUpi {
  String upiName;
  String upiId;
  String remark;
  String type;

  SmallAndLargeAmountUpi({
    required this.upiName,
    required this.upiId,
    required this.remark,
    required this.type,
  });

  // Factory constructor for creating a new SmallAndLargeAmountUpi instance from a map
  factory SmallAndLargeAmountUpi.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SmallAndLargeAmountUpi(
        upiName: '',
        upiId: '',
        remark: '',
        type: '',
      );
    } else {
      return SmallAndLargeAmountUpi(
        upiName: json['upi_name'] ?? '',
        upiId: json['upi_id'] ?? '',
        remark: json['remark'] ?? '',
        type: json['type'] ?? '',
      );
    }
  }

  // Method to convert a SmallAndLargeAmountUpi instance to a map
  Map<String, dynamic> toJson() {
    return {
      'upi_name': upiName,
      'upi_id': upiId,
      'remark': remark,
      'type': type,
    };
  }
}

class BankAccount {
  String video;
  String notice;
  String bankName;
  String accountHolderName;
  String accountNo;
  String ifscCode;

  BankAccount({
    required this.video,
    required this.notice,
    required this.bankName,
    required this.accountHolderName,
    required this.accountNo,
    required this.ifscCode,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return BankAccount(
        video: '',
        notice: '',
        bankName: '',
        accountHolderName: '',
        accountNo: '',
        ifscCode: '',
      );
    } else {
      return BankAccount(
        video: json['video'],
        notice: json['notice'],
        bankName: json['bank_name'],
        accountHolderName: json['account_holder_name'],
        accountNo: json['account_no'],
        ifscCode: json['ifsc_code'],
      );
    }
  }
}

class QrCode {
  String video;
  String notice;
  String qrImage;
  String qrUpiId;

  QrCode(
      {required this.video,
      required this.notice,
      required this.qrImage,
      required this.qrUpiId});

  factory QrCode.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return QrCode(
        video: '',
        notice: '',
        qrImage: '',
        qrUpiId: '',
      );
    } else {
      return QrCode(
        video: json['video'],
        notice: json['notice'],
        qrImage: json['qr_image'],
        qrUpiId: json['qr_upi_id'],
      );
    }
  }
}
