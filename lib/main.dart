import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hire4consult/controller/auth_controller/auth_controller_concrete.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_controller_impl.dart';
import 'package:hire4consult/controller/jobs_controller/jobs_dropdowns_controller.dart';
import 'package:hire4consult/utils/locator.dart';
import 'package:hire4consult/view/login_view/login_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC4sMQy_T0NNsTVkd2mQItnioruTnN2ubc",
          authDomain: "hire4consult-97b13.firebaseapp.com",
          projectId: "hire4consult-97b13",
          storageBucket: "hire4consult-97b13.appspot.com",
          messagingSenderId: "263738459240",
          appId: "1:263738459240:web:9fde3fa3405273116427dd"));

  FirebaseApp jobPosterApp = await Firebase.initializeApp(
    name: "jobPoster", // Unique name for the Job-Poster app
    options: const FirebaseOptions(
        apiKey: "AIzaSyDsfeopvzeLRZqhiCHHFtXax7KUWxc2heo",
        authDomain: "hire4consultemployer.firebaseapp.com",
        projectId: "hire4consultemployer",
        storageBucket: "hire4consultemployer.appspot.com",
        messagingSenderId: "934014512463",
        appId: "1:934014512463:web:5845a54e65f9b3721f693a"),
  );

  // Initialize Firestore for job-poster from the initialized app
  FirebaseFirestore jobPosterFirestore =
      FirebaseFirestore.instanceFor(app: jobPosterApp);

  setupLocator(jobPosterFirestore);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthControllerConcrete()),
      ChangeNotifierProvider(create: (_) => locator<JobsControllerImpl>()),
      ChangeNotifierProvider(create: (_) => locator<JobsDropdownsController>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
