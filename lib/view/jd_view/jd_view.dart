import 'package:flutter/material.dart';
import 'package:hire4consult/controller/application_controller/application_controller_concrete.dart';
import 'package:hire4consult/model/jobs_model/jobs_model.dart';
import 'package:hire4consult/utils/locator.dart';

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
                final applicationController =
                    locator<ApplicationControllerConcrete>();
                // Dummy user details for now
                // Prepare the user details
                Map<String, dynamic> userDetails = {
                  'name': 'Arpit Rahi',
                  'email': 'rk19official@gmail.com',
                  'resumeLink': 'url_to_resume',
                };

                // Prepare the job details (make sure this is the correct job data)
                Map<String, dynamic> jobDetails = job.toJson();

                // Combine all the data
                // Map<String, dynamic> applicationData = {
                //   'jobId': job.id!,
                //   'userId': userId,
                //   'applicationDate': DateTime.now().toIso8601String(),
                //   'jobDetails': jobDetails,
                //   'userDetails': userDetails,
                // };

                // Submit the application
                try {
                  await applicationController.submitApplication(
                    job.id!,
                    userId,
                    jobDetails,
                    userDetails,
                  );

              
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Application submitted successfully')),
                  );
                } catch (e) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error submitting application: $e')),
                  );
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
