import 'package:flutter/material.dart';
import 'package:hire4consult/view/jd_view/jd_view.dart';

import '../../../model/jobs_model/jobs_model.dart';

class JobCard extends StatelessWidget {
  final JobsModel jobDetails;

   const JobCard({Key? key, required this.jobDetails}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JdView(job: jobDetails),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobDetails.position!,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Department: ${jobDetails.department}',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 4.0),
              Text(
                'Specialization: ${jobDetails.specialization}',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 4.0),
              Text(
                'Skills: ${jobDetails.key_skills!.join(', ')}',
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
