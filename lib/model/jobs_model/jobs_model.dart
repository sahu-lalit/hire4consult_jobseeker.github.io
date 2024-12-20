import 'package:json_annotation/json_annotation.dart';

part 'jobs_model.g.dart'; // This will be generated automatically

@JsonSerializable()
class JobsModel {
  final String? id;
  final String? department;
  final String? specialization;
  final List<String>? key_skills;
  final String? position;
  final String? company_name;
  final String? job_description;
  final String? region;
  final String? time_zone;
  final String? job_type;
  final String? posterId;

  JobsModel(
      {required this.id,
      required this.department,
      required this.specialization,
      required this.key_skills,
      required this.position,
      required this.company_name,
      required this.job_description,
      required this.region,
      required this.time_zone,
      required this.job_type,
      required this.posterId
      });

  // Factory method for creating a User instance from JSON
  factory JobsModel.fromJson(Map<String, dynamic> json) =>
      _$JobsModelFromJson(json);

  // Method for converting a User instance to JSON
  Map<String, dynamic> toJson() => _$JobsModelToJson(this);

  JobsModel copyWith(
      {String? id,
      String? department,
      String? specialization,
      List<String>? key_skills,
      String? position,
      String? company_name,
      String? job_description,
      String? region,
      String? time_zone,
      String? job_type,
      String? posterId
      }) {
    return JobsModel(
      id: id ?? this.id,
      department: department ?? this.department,
      specialization: specialization ?? this.specialization,
      key_skills: key_skills ?? this.key_skills,
      position: position ?? this.position,
      company_name: company_name ?? this.company_name,
      job_description: job_description ?? this.job_description,
      region: region ?? this.region,
      time_zone: time_zone ?? this.time_zone,
      job_type: job_type ?? this.job_type,
      posterId: posterId ?? this.posterId
    );
  }
}
