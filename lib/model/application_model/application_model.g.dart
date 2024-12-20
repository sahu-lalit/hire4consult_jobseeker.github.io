// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    ApplicationModel(
      jobId: json['jobId'] as String,
      userId: json['userId'] as String,
      applicationDate: json['applicationDate'] as String,
      jobDetails:
          JobsModel.fromJson(json['jobDetails'] as Map<String, dynamic>),
      userDetails:
          UserModel.fromJson(json['userDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplicationModelToJson(ApplicationModel instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'userId': instance.userId,
      'applicationDate': instance.applicationDate,
      'jobDetails': instance.jobDetails,
      'userDetails': instance.userDetails,
    };
