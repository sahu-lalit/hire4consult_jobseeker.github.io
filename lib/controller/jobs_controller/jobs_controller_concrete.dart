import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_controller.dart';
import 'package:hire4consult/model/jobs_model/jobs_model.dart';

class JobsControllerConcrete with ChangeNotifier implements JobsController {
  final FirebaseFirestore _db = FirebaseFirestore.instance; // Updated
  final String path;
  late CollectionReference ref; // Use late initialization

  JobsControllerConcrete({required this.path}) {
    ref = _db.collection(path);
  }

  @override
  Future<QuerySnapshot> getDataCollection() {
    return ref.get(); // Correct method to get documents in a collection
  }

  @override
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get(); // Updated method
  }

  @override
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots(); // Correct method to get real-time updates
  }

  @override
  Stream<List<JobsModel>> searchJobs({
    required String department,
    required String specialization,
    required String skill,
    required String region,
  }) {
    return _db
        .collection('applications')
        .where('jobDetails.department', isEqualTo: department)
        .where('jobDetails.specialization', isEqualTo: specialization)
        .where('jobDetails.key_skills', arrayContains: skill)
        .where('jobDetails.region', isEqualTo: region)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return JobsModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
