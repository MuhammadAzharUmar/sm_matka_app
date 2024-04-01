class UserStatusModel {
  String message;
  String code;
  String status;
  UserStatusData data;

  UserStatusModel({
    required this.message,
    required this.code,
    required this.status,
    required this.data,
  });

  factory UserStatusModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return UserStatusModel(
        message: "",
        code: "",
        status: "",
        data: UserStatusData.fromJson({}),
      );
    } else {
      return UserStatusModel(
        message: json['message'] ?? "",
        code: json['code'] ?? "",
        status: json['status'] ?? "",
        data: UserStatusData.fromJson(json['data'] ?? {}),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
      'data': data.toJson(),
    };
  }
}

class UserStatusData {
  String availablePoints;
  String transfer;
  String upiName;
  String upiPaymentId;
  String maximumDeposit;
  String minimumDeposit;
  String maximumWithdraw;
  String minimumWithdraw;
  String maximumTransfer;
  String minimumTransfer;
  String maximumBidAmount;
  String minimumBidAmount;

  UserStatusData({
    required this.availablePoints,
    required this.transfer,
    required this.upiName,
    required this.upiPaymentId,
    required this.maximumDeposit,
    required this.minimumDeposit,
    required this.maximumWithdraw,
    required this.minimumWithdraw,
    required this.maximumTransfer,
    required this.minimumTransfer,
    required this.maximumBidAmount,
    required this.minimumBidAmount,
  });

  factory UserStatusData.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      
    
    return UserStatusData(
      availablePoints: json['available_points'] ?? "",
      transfer: json['transfer'] ?? "",
      upiName: json['upi_name'] ?? "",
      upiPaymentId: json['upi_payment_id'] ?? "",
      maximumDeposit: json['maximum_deposit'] ?? "",
      minimumDeposit: json['minimum_deposit'] ?? "",
      maximumWithdraw: json['maximum_withdraw'] ?? "",
      minimumWithdraw: json['minimum_withdraw'] ?? "",
      maximumTransfer: json['maximum_transfer'] ?? "",
      minimumTransfer: json['minimum_transfer'] ?? "",
      maximumBidAmount: json['maximum_bid_amount'] ?? "",
      minimumBidAmount: json['minimum_bid_amount'] ?? "",
    );
    } else {
       return UserStatusData(
      availablePoints: "",
      transfer: "",
      upiName:  "",
      upiPaymentId: "",
      maximumDeposit: "",
      minimumDeposit: "",
      maximumWithdraw: "",
      minimumWithdraw: "",
      maximumTransfer: "",
      minimumTransfer: "",
      maximumBidAmount: "",
      minimumBidAmount: "",
    );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'available_points': availablePoints,
      'transfer': transfer,
      'upi_name': upiName,
      'upi_payment_id': upiPaymentId,
      'maximum_deposit': maximumDeposit,
      'minimum_deposit': minimumDeposit,
      'maximum_withdraw': maximumWithdraw,
      'minimum_withdraw': minimumWithdraw,
      'maximum_transfer': maximumTransfer,
      'minimum_transfer': minimumTransfer,
      'maximum_bid_amount': maximumBidAmount,
      'minimum_bid_amount': minimumBidAmount,
    };
  }
}
