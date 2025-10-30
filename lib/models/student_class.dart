
import 'package:hive/hive.dart';

part 'student_class.g.dart';

@HiveType(typeId: 0)
class StudentClass extends HiveObject {

  @HiveField(0)
  String? className;

  @HiveField(1)
  List<int> grades = [];

  @HiveField(2)
  List<String> gradesType = [];

}
