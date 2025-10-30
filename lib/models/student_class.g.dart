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
      ..grades = (fields[1] as List).cast<int>()
      ..gradesType = (fields[2] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, StudentClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.grades)
      ..writeByte(2)
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
