// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsModel _$JobsModelFromJson(Map<String, dynamic> json) => JobsModel(
      id: json['id'] as String?,
      department: json['department'] as String?,
      specialization: json['specialization'] as String?,
      key_skills: (json['key_skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      position: json['position'] as String?,
      company_name: json['company_name'] as String?,
      job_description: json['job_description'] as String?,
      region: json['region'] as String?,
      time_zone: json['time_zone'] as String?,
      job_type: json['job_type'] as String?,
      posterId: json['posterId'] as String?,
    );

Map<String, dynamic> _$JobsModelToJson(JobsModel instance) => <String, dynamic>{
      'id': instance.id,
      'department': instance.department,
      'specialization': instance.specialization,
      'key_skills': instance.key_skills,
      'position': instance.position,
      'company_name': instance.company_name,
      'job_description': instance.job_description,
      'region': instance.region,
      'time_zone': instance.time_zone,
      'job_type': instance.job_type,
      'posterId': instance.posterId,
    };
