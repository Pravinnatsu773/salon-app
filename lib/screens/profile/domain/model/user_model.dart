// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String role;
  bool status;
  String id;
  int phoneNumber;
  DateTime createdAt;
  dynamic email;
  dynamic otp;
  dynamic otpExpiry;
  DateTime updatedAt;
  String username;
  String dob;
  String firstName;
  String lastName;
  String gender;

  UserModel({
    required this.role,
    required this.status,
    required this.id,
    required this.phoneNumber,
    required this.createdAt,
    required this.email,
    required this.otp,
    required this.otpExpiry,
    required this.updatedAt,
    required this.username,
    required this.dob,
    required this.firstName,
    required this.lastName,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        role: json["role"],
        status: json["status"],
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        email: json["email"],
        otp: json["otp"],
        otpExpiry: json["otpExpiry"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
        dob: json["DOB"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "status": status,
        "_id": id,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt.toIso8601String(),
        "email": email,
        "otp": otp,
        "otpExpiry": otpExpiry,
        "updatedAt": updatedAt.toIso8601String(),
        "username": username,
        "DOB": dob,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
      };
}
