class AppDetailsModel {
  String message;
  String code;
  String status;
  Data data;

  AppDetailsModel(
      {required this.message,
      required this.code,
      required this.status,
      required this.data});

  static fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return AppDetailsModel(
        message: json['message'],
        code: json['code'],
        status: json['status'],
        data: Data.fromJson(
          json['data'],
        ),
      );
    } else {
      return AppDetailsModel(
        message: "",
        code: "",
        status: "",
        data: Data.fromJson(
          {},
        ),
      );
    }
  }

  Map<String, dynamic> toJson(AppDetailsModel appDetailsModel) {
    final Map<String, dynamic> data = {};
    data['message'] = appDetailsModel.message;
    data['code'] = appDetailsModel.code;
    data['status'] = appDetailsModel.status;
    data['data'] = Data.toJson(appDetailsModel.data);
    return data;
  }
}

class Data {
  String bannerMarquee;
  ContactDetails contactDetails;
  BannerImage bannerImage;
  List<Banner> banner;
  ProjectStatus projectStatus;
  String withdrawOpenTime;
  String withdrawCloseTime;
  String addFundNotice;
  String withdrawNotice;
  String appNotice;
  String appLink;
  String appStatus;
  String adminMessage;
  String shareMessage;

  Data({
    required this.bannerMarquee,
    required this.contactDetails,
    required this.bannerImage,
    required this.banner,
    required this.projectStatus,
    required this.withdrawOpenTime,
    required this.withdrawCloseTime,
    required this.addFundNotice,
    required this.withdrawNotice,
    required this.appNotice,
    required this.appLink,
    required this.appStatus,
    required this.adminMessage,
    required this.shareMessage,
  });

  static fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return Data(
        bannerMarquee: json['banner_marquee'],
        contactDetails: ContactDetails.fromJson(json['contact_details']),
        bannerImage: BannerImage.fromJson(json['banner_image']),
        banner: (json['banner'] as List<dynamic>)
            .map((e) => Banner.fromJson(e))
            .toList(),
        projectStatus: ProjectStatus.fromJson(json['project_status']),
        withdrawOpenTime: json['withdraw_open_time'],
        withdrawCloseTime: json['withdraw_close_time'],
        addFundNotice: json['add_fund_notice'],
        withdrawNotice: json['withdraw_notice'],
        appNotice: json['app_notice'],
        appLink: json['app_link'],
        appStatus: json['app_status'],
        adminMessage: json['admin_message'],
        shareMessage: json['share_message'],
      );
    } else {
      return Data(
        bannerMarquee: "Welcome",
        contactDetails: ContactDetails.fromJson({}),
        bannerImage: BannerImage.fromJson({}),
        banner: [],
        projectStatus: ProjectStatus.fromJson({}),
        withdrawOpenTime: "",
        withdrawCloseTime: "",
        addFundNotice: "",
        withdrawNotice: "",
        appNotice: "",
        appLink: "",
        appStatus: "",
        adminMessage: "",
        shareMessage: "",
      );
    }
  }

  static Map<String, dynamic> toJson(Data appData) {
    final Map<String, dynamic> data = {};
    data['banner_marquee'] = appData.bannerMarquee;
    data['contact_details'] = ContactDetails.toJson(appData.contactDetails);
    data['banner_image'] = BannerImage.toJson(appData.bannerImage);
    data['banner'] = appData.banner.map((e) => Banner.toJson(e)).toList();
    data['project_status'] = ProjectStatus.toJson(appData.projectStatus);
    data['withdraw_open_time'] = appData.withdrawOpenTime;
    data['withdraw_close_time'] = appData.withdrawCloseTime;
    data['add_fund_notice'] = appData.addFundNotice;
    data['withdraw_notice'] = appData.withdrawNotice;
    data['app_notice'] = appData.appNotice;
    data['app_link'] = appData.appLink;
    data['app_status'] = appData.appStatus;
    data['admin_message'] = appData.adminMessage;
    data['share_message'] = appData.shareMessage;
    return data;
  }
}

class ContactDetails {
  String whatsappNo;
  String mobileNo1;
  String mobileNo2;
  String email1;
  String telegramNo;
  String withdrawProof;

  ContactDetails({
    required this.whatsappNo,
    required this.mobileNo1,
    required this.mobileNo2,
    required this.email1,
    required this.telegramNo,
    required this.withdrawProof,
  });

  static fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return ContactDetails(
        whatsappNo: json['whatsapp_no'],
        mobileNo1: json['mobile_no_1'],
        mobileNo2: json['mobile_no_2'],
        email1: json['email_1'],
        telegramNo: json['telegram_no'],
        withdrawProof: json['withdraw_proof'],
      );
    } else {
      return ContactDetails(
        whatsappNo: "",
        mobileNo1: "",
        mobileNo2: "",
        email1: "",
        telegramNo: "",
        withdrawProof: "",
      );
    }
  }

  static Map<String, dynamic> toJson(ContactDetails contactDetails) {
    final Map<String, dynamic> data = {};
    data['whatsapp_no'] = contactDetails.whatsappNo;
    data['mobile_no_1'] = contactDetails.mobileNo1;
    data['mobile_no_2'] = contactDetails.mobileNo2;
    data['email_1'] = contactDetails.email1;
    data['telegram_no'] = contactDetails.telegramNo;
    data['withdraw_proof'] = contactDetails.withdrawProof;
    return data;
  }
}

class BannerImage {
  String bannerImg1;
  String bannerImg2;
  String bannerImg3;

  BannerImage({
    required this.bannerImg1,
    required this.bannerImg2,
    required this.bannerImg3,
  });

  static fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return BannerImage(
        bannerImg1: json['banner_img_1'],
        bannerImg2: json['banner_img_2'],
        bannerImg3: json['banner_img_3'],
      );
    } else {
      return BannerImage(
        bannerImg1: "",
        bannerImg2: "",
        bannerImg3: "",
      );
    }
  }

  static Map<String, dynamic> toJson(BannerImage bannerImage) {
    final Map<String, dynamic> data = {};
    data['banner_img_1'] = bannerImage.bannerImg1;
    data['banner_img_2'] = bannerImage.bannerImg2;
    data['banner_img_3'] = bannerImage.bannerImg3;
    return data;
  }
}

class Banner {
  String image;

  Banner({
    required this.image,
  });

  static Banner fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return Banner(image: json["image"]);
    } else {
      return Banner(image: "");
    }
  }

  static Map<String, dynamic> toJson(Banner banner) {
    final Map<String, dynamic> data = {};
    data['image'] = banner.image;
    return data;
  }
}

class ProjectStatus {
  String mainMarket;
  String starlineMarket;
  String galidesawarMarket;
  String bannerStatus;
  String marqueeStatus;

  ProjectStatus({
    required this.mainMarket,
    required this.starlineMarket,
    required this.galidesawarMarket,
    required this.bannerStatus,
    required this.marqueeStatus,
  });

  static ProjectStatus fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
    return  ProjectStatus(    mainMarket : json['main_market'],
    starlineMarket : json['starline_market'],
    galidesawarMarket : json['galidesawar_market'],
    bannerStatus : json['banner_status'],
    marqueeStatus : json['marquee_status'],);
    } else {
      return  ProjectStatus(    mainMarket : "",
    starlineMarket : "",
    galidesawarMarket : "",
    bannerStatus : "",
    marqueeStatus : "",);
    }

  }

  static Map<String, dynamic> toJson(ProjectStatus projectStatus) {
    final Map<String, dynamic> data = {};
    data['main_market'] = projectStatus.mainMarket;
    data['starline_market'] = projectStatus.starlineMarket;
    data['galidesawar_market'] = projectStatus.galidesawarMarket;
    data['banner_status'] = projectStatus.bannerStatus;
    data['marquee_status'] = projectStatus.marqueeStatus;
    return data;
  }
}
