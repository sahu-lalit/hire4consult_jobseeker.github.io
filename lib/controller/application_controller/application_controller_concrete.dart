import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hire4consult/controller/application_controller/application_controller.dart';

class ApplicationControllerConcrete implements ApplicationController {
  final FirebaseFirestore _jobPosterDb;

  ApplicationControllerConcrete(this._jobPosterDb);

  @override
  Future<void> submitApplication(String jobId, String userId, Map<String, dynamic> jobDetails, Map<String, dynamic> userDetails) async {
    CollectionReference ref = _jobPosterDb.collection('job-applications');

    await ref.add({
      'jobId': jobId,
      'userId': userId,
      'applicationDate': DateTime.now().toIso8601String(),
      'jobDetails': jobDetails,
      'userDetails': userDetails,
      'posterId': jobDetails['posterId'],
    });
  }
  
  }
  