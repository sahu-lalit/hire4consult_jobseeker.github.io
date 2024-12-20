import 'package:hire4consult/model/jobs_model/jobs_model.dart';
import 'package:hire4consult/model/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application_model.g.dart';

@JsonSerializable()
class ApplicationModel {
  final String jobId;
  final String userId;
  final String applicationDate;
  final JobsModel jobDetails;
  final UserModel userDetails;

  ApplicationModel({
    required this.jobId,
    required this.userId,
    required this.applicationDate,
    required this.jobDetails,
    required this.userDetails,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationModelToJson(this);
}
