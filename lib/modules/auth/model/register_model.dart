class RegisterModel {
  int? status;
  String? message;
  Data? data;
  String? token;

  RegisterModel({this.status, this.message, this.data, this.token});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  String? userId;
  String? userPhoneNumber;
  String? userEmail;
  String? userPassword;
  String? userName;
  String? userGender;
  String? userSigninMethod;
  String? userExtraAuthId;
  String? userCountryCode;
  String? userRegion;
  String? userLocation;
  String? userAppLang;
  List<String>? userPhoneModel;
  List<String>? userPhoneLang;
  List<String>? userOs;
  List<String>? userOsVersion;
  List<String>? userToken;
  String? userComment;
  bool? userPremium;
  String? userPremiumExpiresAt;
  String? userImageLink;
  String? userImageName;
  String? userAppVersion;
  String? userNotificationId;
  bool? userNotification;
  String? userCreateAt;

  Data({
    this.userId,
    this.userPhoneNumber,
    this.userEmail,
    this.userPassword,
    this.userName,
    this.userGender,
    this.userSigninMethod,
    this.userExtraAuthId,
    this.userCountryCode,
    this.userRegion,
    this.userLocation,
    this.userAppLang,
    this.userPhoneModel,
    this.userPhoneLang,
    this.userOs,
    this.userOsVersion,
    this.userToken,
    this.userComment,
    this.userPremium,
    this.userPremiumExpiresAt,
    this.userImageLink,
    this.userImageName,
    this.userAppVersion,
    this.userNotificationId,
    this.userNotification,
    this.userCreateAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userPhoneNumber = json['user_phone_number'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userName = json['user_name'];
    userGender = json['user_gender'];
    userSigninMethod = json['user_signin_method'];
    userExtraAuthId = json['user_extra_auth_id'];
    userCountryCode = json['user_country_code'];
    userRegion = json['user_region'];
    userLocation = json['user_location'];
    userAppLang = json['user_app_lang'];
    userPhoneModel = json['user_phone_model'] != null
        ? List<String>.from(json['user_phone_model'])
        : null;
    userPhoneLang = json['user_phone_lang'] != null
        ? List<String>.from(json['user_phone_lang'])
        : null;
    userOs =
        json['user_os'] != null ? List<String>.from(json['user_os']) : null;
    userOsVersion = json['user_os_version'] != null
        ? List<String>.from(json['user_os_version'])
        : null;
    userToken = json['user_token'] != null
        ? List<String>.from(json['user_token'])
        : null;
    userComment = json['user_comment'];
    userPremium = json['user_premium'];
    userPremiumExpiresAt = json['user_premium_expires_at'];
    userImageLink = json['user_image_link'];
    userImageName = json['user_image_name'];
    userAppVersion = json['user_app_version'].toString();
    userNotificationId = json['user_notification_id'];
    userNotification = json['user_notification'];
    userCreateAt = json['user_create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_phone_number'] = userPhoneNumber;
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['user_name'] = userName;
    data['user_gender'] = userGender;
    data['user_signin_method'] = userSigninMethod;
    data['user_extra_auth_id'] = userExtraAuthId;
    data['user_country_code'] = userCountryCode;
    data['user_region'] = userRegion;
    data['user_location'] = userLocation;
    data['user_app_lang'] = userAppLang;
    data['user_phone_model'] = userPhoneModel;
    data['user_phone_lang'] = userPhoneLang;
    data['user_os'] = userOs;
    data['user_os_version'] = userOsVersion;
    data['user_token'] = userToken;
    data['user_comment'] = userComment;
    data['user_premium'] = userPremium;
    data['user_premium_expires_at'] = userPremiumExpiresAt;
    data['user_image_link'] = userImageLink;
    data['user_image_name'] = userImageName;
    data['user_app_version'] = userAppVersion;
    data['user_notification_id'] = userNotificationId;
    data['user_notification'] = userNotification;
    data['user_create_at'] = userCreateAt;
    return data;
  }
}

class UserData {
  final String? userPhoneNumber;
  final String? userEmail;
  final String? userPassword;
  final String? userName;
  final String? userGender;
  final String? userSigninMethod;
  final String? userExtraAuthId;
  final String? userCountryCode;
  final String? userRegion;
  final String? userLatitude;
  final String? userLongitude;
  final String? userAppLang;
  final String? userPhoneModel;
  final String? userPhoneLang;
  final String? userOs;
  final String? userOsVersion;
  final String? userToken;
  final String? userAppVersion;
  final String? notificationId;
  final bool? notification;

  UserData({
    this.userPhoneNumber,
    this.userEmail,
    this.userPassword,
    this.userName,
    this.userGender,
    this.userSigninMethod,
    this.userExtraAuthId,
    this.userCountryCode,
    this.userRegion,
    this.userLatitude,
    this.userLongitude,
    this.userAppLang,
    this.userPhoneModel,
    this.userPhoneLang,
    this.userOs,
    this.userOsVersion,
    this.userToken,
    this.userAppVersion,
    this.notificationId,
    this.notification,
  });
}
