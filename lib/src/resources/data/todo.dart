import 'package:flutter/material.dart';

enum Level { basic, important, urgent }

class Todo {
  String name;
  DateTime dueDate;
  TimeOfDay dueTime;
  String? place;
  bool isComplete;
  Color color;
  final int id;
  Level level;

  Todo({
    required this.id,
    required this.name,
    required this.dueDate,
    this.place,
    this.level = Level.basic,
    this.isComplete = false,
    this.color = const Color(0xFF11FAD5),
    TimeOfDay? dueTime,
  }) : dueTime = dueTime ?? TimeOfDay.now();

  Todo copyWith({
    int? id,
    String? name,
    DateTime? dueDate,
    TimeOfDay? dueTime,
    Color? color,
    Level? level,
    String? place,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      color: color ?? this.color,
      level: level ?? this.level,
      place: place,
    );
  }

  void setFinished(bool? isComplete) {
    this.isComplete = isComplete ?? !this.isComplete;
  }
}
