// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentClassAdapter extends TypeAdapter<StudentClass> {
  @override
  final int typeId = 0;

  @override
  StudentClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentClass()
      ..className = fields[0] as String?
      ..classTeacher = fields[1] as String?
      ..classCredit = fields[2] as double?
      ..homeworkPercent = fields[3] as double?
      ..testPercent = fields[4] as double?
      ..quizPercent = fields[5] as double?
      ..otherPercent = fields[6] as double?
      ..grades = (fields[7] as List).cast<double>()
      ..gradesType = (fields[8] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, StudentClass obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.classTeacher)
      ..writeByte(2)
      ..write(obj.classCredit)
      ..writeByte(3)
      ..write(obj.homeworkPercent)
      ..writeByte(4)
      ..write(obj.testPercent)
      ..writeByte(5)
      ..write(obj.quizPercent)
      ..writeByte(6)
      ..write(obj.otherPercent)
      ..writeByte(7)
      ..write(obj.grades)
      ..writeByte(8)
      ..write(obj.gradesType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
