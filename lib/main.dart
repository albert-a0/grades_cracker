import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:grades_cracker/models/student_class.dart';
import 'package:grades_cracker/screens/app_assistant.dart';
import 'package:grades_cracker/screens/class_add_screen.dart';
import 'package:grades_cracker/screens/class_info_screen.dart';
import 'package:grades_cracker/screens/classes_screen.dart';
import 'package:grades_cracker/screens/dash_screen.dart';
import 'package:grades_cracker/screens/questions_screen.dart';
import 'package:grades_cracker/screens/study_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(StudentClassAdapter());
  await Hive.openBox("appbox3");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: [
          GoRoute(path: "/",builder: (ctx,state){return DashScreen();}),
          GoRoute(path: "/classes",builder: (ctx,state){return ClassesScreen();}),
          GoRoute(path: "/classes/add",builder: (ctx,state){return ClassAddScreen();}),
          GoRoute(path: "/classes/info",builder: (ctx,state){
            final selectedClass = state.extra as StudentClass;

            return ClassInfoScreen(studentClass: selectedClass);}),
          GoRoute(path: "/aiassistant",builder: (ctx,state) {return AppAssistant();}),
          GoRoute(path: "/study",builder: (ctx,state) {return StudyScreen();}),
          GoRoute(path: "/study/questions",builder: (ctx,state) {
            final questions = state.extra as String;

            return QuestionsScreen(questions);})
        ]  
      ),
    );

  }


}