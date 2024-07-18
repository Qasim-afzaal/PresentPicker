import 'package:json_annotation/json_annotation.dart';
import 'package:present_picker/model/user_data_model.dart';

part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResModel {
  bool ?status;
  LoginData? data;

  LoginResModel(
      {this.status,
      this.data,});

  factory LoginResModel.fromJson(Map<String, dynamic> map) =>
      _$LoginResModelFromJson(map);

  Map<String, dynamic> toJson() => _$LoginResModelToJson(this);
}