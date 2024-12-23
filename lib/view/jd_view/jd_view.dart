import 'package:flutter/material.dart';
import 'package:hire4consult/controller/application_controller/application_controller_concrete.dart';
import 'package:hire4consult/model/jobs_model/jobs_model.dart';
import 'package:hire4consult/utils/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JdView extends StatelessWidget {
  final JobsModel job;

  const JdView({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final userId = 'sampleUserId'; // Replace with actual userId

    return Scaffold(
      appBar: AppBar(title: Text(job.position!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Job Title: ${job.position}'),
            Text('Department: ${job.department}'),
            Text('Specialization: ${job.specialization}'),
            Text('Key Skills: ${job.key_skills!.join(', ')}'),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  final userId = user.uid;
                  final jobDocRef =
                      FirebaseFirestore.instance.collection('jobs').doc(job.id);

                  await jobDocRef.update({
                    'applicants': FieldValue.arrayUnion([userId])
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('You have successfully applied for the job!')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'You need to be logged in to apply for the job.')));
                }
              },
              child: Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
