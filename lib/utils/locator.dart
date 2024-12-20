import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hire4consult/controller/application_controller/application_controller_concrete.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_controller_concrete.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_controller_impl.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_dropdowns_controller.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator(FirebaseFirestore jobPosterFirestore) {
  // Register FirebaseFirestore for Job Seeker
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
      instanceName: 'jobSeekerFirestore');

  // Register FirebaseFirestore for Job Poster
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instanceFor(app: Firebase.app()),
      instanceName: 'jobPosterFirestore');

  locator.registerLazySingleton(() => JobsControllerConcrete(path: 'jobs'));
  locator.registerLazySingleton(() => JobsControllerImpl());
  locator.registerLazySingleton<JobsDropdownsController>(
      () => JobsDropdownsController());
  locator.registerLazySingleton(
      () => ApplicationControllerConcrete(jobPosterFirestore));
}
