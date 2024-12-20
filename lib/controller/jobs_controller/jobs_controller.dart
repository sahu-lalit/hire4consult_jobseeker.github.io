import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hire4consult/model/jobs_model/jobs_model.dart';


abstract class JobsController {
  Future<QuerySnapshot> getDataCollection();
  Stream<QuerySnapshot> streamDataCollection();
  Future<DocumentSnapshot> getDocumentById(String id);
    // New method for filtered job search
  Stream<List<JobsModel>> searchJobs({
    required String department,
    required String specialization,
    required String skill,
    required String region,
  });

}
