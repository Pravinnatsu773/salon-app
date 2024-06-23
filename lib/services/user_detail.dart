class UserDetail {
  static final UserDetail _instance = UserDetail._internal();

  factory UserDetail() {
    return _instance;
  }

  UserDetail._internal();

  String? role;
  bool? status;
  String? id;
  int? phoneNumber;
  DateTime? createdAt;
  String? email;
  String? otp;
  String? otpExpiry;
  DateTime? updatedAt;
  String? username;
  String? dob;
  String? firstName;
  String? lastName;
  String? gender;
}
