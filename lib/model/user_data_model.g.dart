// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      token: json['token'] as String,
      // email_verified: json['email_verified'] as bool,
      email: json['email'] as String?,
      phone_verified: json['phone_verified'] as bool?,
      is_public_profile: json['is_public_profile'] as bool?,
      // version: json['version'] as int,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'token': instance.token,
      // 'email_verified': instance.email_verified,
      'phone_verified': instance.phone_verified,
      'is_public_profile': instance.is_public_profile,
      // 'version': instance.version,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'username': instance.username,
      'email': instance.email,
      'avatar': instance.avatar,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
