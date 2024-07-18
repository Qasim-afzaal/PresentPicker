// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResModel _$LoginResModelFromJson(Map<String, dynamic> json) =>
    LoginResModel(
      status: json['status'] as bool?,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResModelToJson(LoginResModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.toJson(),
    };
