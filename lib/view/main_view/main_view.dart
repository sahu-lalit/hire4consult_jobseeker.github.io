import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_controller_impl.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_dropdowns_controller.dart';
import 'package:hire4consult/model/jobs_model/jobs_model.dart';
import 'package:hire4consult/view/main_view/widgets/job_card.dart';
import 'package:hire4consult/view/profile_view/profile_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var jobsController = Provider.of<JobsControllerImpl>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0 , 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 260,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/hire_logo.png'),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    'This is a Minimum Viable Product',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ProfileView()));
                    },
                    child: Icon(
                      Icons.account_box,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<JobsDropdownsController>(
                  builder: (context, filterController, child) {
                    return DropdownButton<String>(
                      value: filterController.selectedDepartment,
                      hint: const Text('Select Department'),
                      items: JobsDropdownsController.department
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        filterController.updateDepartment(newValue);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<JobsDropdownsController>(
                  builder: (context, filterController, child) {
                    return DropdownButton<String>(
                      value: filterController.selectedSpecialization,
                      hint: const Text('Select Specialization'),
                      items: JobsDropdownsController.specializations
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        filterController.updateSpecialization(newValue);
                      },
                    );
                  },
                ),
              ),
              // Multi-Selectable Dropdown for Skills
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<JobsDropdownsController>(
                  builder: (context, filterController, child) {
                    return GestureDetector(
                      onTap: () {
                        _showSkillsDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              filterController.selectedSkills.isEmpty
                                  ? 'Select Skills'
                                  : filterController.selectedSkills.length == 1
                                      ? filterController.selectedSkills.first
                                      : '${filterController.selectedSkills.first}, ...',
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<JobsDropdownsController>(
                  builder: (context, filterController, child) {
                    return GestureDetector(
                      onTap: () {
                        _showRegionsDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(filterController.selectedRegions.isEmpty
                                ? 'Select Region'
                                : filterController.selectedRegions.first +
                                    (filterController.selectedRegions.length > 1
                                        ? '...'
                                        : '')),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
            Expanded(
              child: Consumer<JobsDropdownsController>(
                  builder: (context, dropDownController, child) {
                if (dropDownController.selectedDepartment != null &&
                    dropDownController.selectedSpecialization != null &&
                    dropDownController.selectedSkills.isNotEmpty) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: jobsController.fetchJobsAsStream(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: SpinKitWave(
                          color: Colors
                              .orangeAccent, // Set the color of your choice
                          size: 50.0, // Set the size of the animation
                        ));
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No Jobs Available at the moment'));
                      }
                      // Map each document to JobsModel
                      List<JobsModel> jobs = snapshot.data!.docs
                          .map((doc) => JobsModel.fromJson(
                                  doc.data() as Map<String, dynamic>)
                              .copyWith(id: doc.id))
                          .where((job) =>
                              job.department ==
                                  dropDownController.selectedDepartment &&
                              job.specialization ==
                                  dropDownController.selectedSpecialization &&
                              job.key_skills!.any((skill) => dropDownController
                                  .selectedSkills
                                  .contains(skill)) &&
                              dropDownController.selectedRegions
                                  .contains(job.region))
                          .toList();

                      if (jobs.isEmpty) {
                        return const Center(
                            child: Text(
                                'No jobs found for the selected criteria'));
                      }

                      return ListView.builder(
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return JobCard(
                              jobDetails: job); // Customize JobCard as needed
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Please select a department and skill'),
                        SizedBox(height: 20),
                        SpinKitPouringHourGlass(
                          color: Colors.orangeAccent,
                          size: 50.0,
                        )
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ));
  }

  // Function to show the multi-select dialog for skills
  void _showSkillsDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> skills = JobsDropdownsController.skills;

        return AlertDialog(
          title: const Text('Select Skills'),
          content: Consumer<JobsDropdownsController>(
            builder: (context, filterController, child) {
              return SingleChildScrollView(
                child: Column(
                  children: skills.map((String skill) {
                    return CheckboxListTile(
                      title: Text(skill),
                      value: filterController.selectedSkills.contains(skill),
                      onChanged: (bool? selected) {
                        filterController.toggleSkillSelection(skill, selected!);
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                final jobsController =
                    Provider.of<JobsControllerImpl>(context, listen: false);
                jobsController.fetchJobs();
              },
            ),
          ],
        );
      },
    );
  }

  void _showRegionsDialog(BuildContext context) {
    final filterController =
        Provider.of<JobsDropdownsController>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Region'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: JobsDropdownsController.region.map((region) {
                  return CheckboxListTile(
                    title: Text(region),
                    value: filterController.selectedRegions.contains(region),
                    onChanged: (isChecked) {
                      setState(() {
                        if (isChecked == true) {
                          filterController.selectedRegions.add(region);
                        } else {
                          filterController.selectedRegions.remove(region);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                filterController
                    .updateRegions(filterController.selectedRegions);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
