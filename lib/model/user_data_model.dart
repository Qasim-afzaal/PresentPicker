import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class LoginData {
  //final String active;
  final String token;
  // final bool email_verified;
  final bool? phone_verified;
  late bool? is_public_profile;
  // final int version;
  //final String passwordCount;
  final String? firstname;
  final String lastname;
  late String? username;
  late String? email;
  late String? avatar;
  late String? created_at;
  late String updated_at;


  LoginData({
    required this.token,
    // this.email_verified,
    this.email,
    this.phone_verified,
    this.is_public_profile,
    // required this.version,
    this.firstname,
    required this.lastname,
    this.username,
    this.avatar,
    this.created_at,
    required this.updated_at,
  });
  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
