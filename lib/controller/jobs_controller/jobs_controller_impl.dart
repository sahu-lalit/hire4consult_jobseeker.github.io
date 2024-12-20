import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_controller_concrete.dart';
import 'package:hire4consult/utils/locator.dart';

import '../../model/jobs_model/jobs_model.dart';

class JobsControllerImpl extends ChangeNotifier {
  final JobsControllerConcrete _api = locator<JobsControllerConcrete>(); // Use your concrete implementation
  List<JobsModel> jobs = [];

Future<List<JobsModel>> fetchJobs() async {
  var result = await _api.getDataCollection();
  jobs = [];

  for (var doc in result.docs) {
    // Create a JobsModel from the document data
    var job = JobsModel.fromJson(doc.data() as Map<String, dynamic>);
    
    // If you added the id field in the JobsModel
    jobs.add(job.copyWith(id: doc.id)); // Assuming you added an 'id' field in JobsModel
  }

  notifyListeners(); // Notify listeners about the update
  return jobs;
}

  Stream<QuerySnapshot> fetchJobsAsStream() {
    return _api.streamDataCollection();
  }

  Future<JobsModel> getJobById(String id) async {
    var doc = await _api.getDocumentById(id);
    return JobsModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Stream<List<JobsModel>> searchJobs({
    required String department,
    required String specialization,
    required String skill,
    required String region,
  }) {
    return _api.searchJobs(
      department: department,
      specialization: specialization,
      skill: skill,
      region: region,
    );
  }

}
