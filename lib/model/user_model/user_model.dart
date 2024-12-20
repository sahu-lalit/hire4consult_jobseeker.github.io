import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String resumeLink;
  final String fcmToken; // For sending notifications to job poster

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.resumeLink,
    required this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}