// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.userId,
        required this.userName,
        required this.userInfo,
        required this.userPhone,
        required this.userEmail,
        required this.userPassword,
    });

    String userId;
    String userName;
    String userInfo;
    String userPhone;
    String userEmail;
    String userPassword;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        userName: json["user_name"],
        userInfo: json["user_info"],
        userPhone: json["user_phone"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_info": userInfo,
        "user_phone": userPhone,
        "user_email": userEmail,
        "user_password": userPassword,
    };
}
