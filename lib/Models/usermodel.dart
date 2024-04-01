class UserModel {
  String message;
  String code;
  String status;
  String token;
  UserData data;

  UserModel({
    required this.message,
    required this.code,
    required this.status,
    required this.token,
    required this.data,
  });

  factory UserModel.fromJson(
      {required Map<String, dynamic> json, required String token}) {
    if (json.isEmpty) {
      return UserModel(
        token: "",
        message: "",
        code: "",
        status: "",
        data: UserData.fromJson({}),
      );
    } else {
      return UserModel(
        token: token,
        message: json['message'] ?? "",
        code: json['code'] ?? "",
        status: json['status'] ?? "",
        data: UserData.fromJson(json['data'] ?? {}),
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

//user data model
class UserData {
  String username;
  String mobile;
  String email;
  String bankName;
  String accountHolderName;
  String ifscCode;
  String branchAddress;
  String bankAccountNo;
  String paytmMobileNo;
  String phonepeMobileNo;
  String gpayMobileNo;
  String pendingNoti;

  UserData({
    required this.username,
    required this.mobile,
    required this.email,
    required this.bankName,
    required this.accountHolderName,
    required this.ifscCode,
    required this.branchAddress,
    required this.bankAccountNo,
    required this.paytmMobileNo,
    required this.phonepeMobileNo,
    required this.gpayMobileNo,
    required this.pendingNoti,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return UserData(
        username: "",
        mobile: "",
        email: "",
        bankName: "",
        accountHolderName: "",
        ifscCode: "",
        branchAddress: "",
        bankAccountNo: "",
        paytmMobileNo: "",
        phonepeMobileNo: "",
        gpayMobileNo: "",
        pendingNoti: "0",
      );
    } else {
      return UserData(
        username: json['username'] ?? "",
        mobile: json['mobile'] ?? "",
        email: json['email'] ?? "",
        bankName: json['bank_name'] ?? "",
        accountHolderName: json['account_holder_name'] ?? "",
        ifscCode: json['ifsc_code'] ?? "",
        branchAddress: json['branch_address'] ?? "",
        bankAccountNo: json['bank_account_no'] ?? "",
        paytmMobileNo: json['paytm_mobile_no'] ?? "",
        phonepeMobileNo: json['phonepe_mobile_no'] ?? "",
        gpayMobileNo: json['gpay_mobile_no'] ?? "",
        pendingNoti: json['pending_noti'] ?? 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'mobile': mobile,
      'email': email,
      'bank_name': bankName,
      'account_holder_name': accountHolderName,
      'ifsc_code': ifscCode,
      'branch_address': branchAddress,
      'bank_account_no': bankAccountNo,
      'paytm_mobile_no': paytmMobileNo,
      'phonepe_mobile_no': phonepeMobileNo,
      'gpay_mobile_no': gpayMobileNo,
      'pending_noti': pendingNoti,
    };
  }
}
