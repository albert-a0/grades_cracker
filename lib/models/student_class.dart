
import 'dart:ffi';

import 'package:hive/hive.dart';

part 'student_class.g.dart';

@HiveType(typeId: 0)
class StudentClass extends HiveObject {

  @HiveField(0)
  String? className;

  @HiveField(1)
  String? classTeacher;

  @HiveField(2)
  double? classCredit;


  @HiveField(3)
  double? homeworkPercent;

  @HiveField(4)
  double? testPercent;

  @HiveField(5)
  double? quizPercent;

  @HiveField(6)
  double? otherPercent;


  @HiveField(7)
  List<double> grades = [];

  @HiveField(8)
  List<String> gradesType = [];

}
