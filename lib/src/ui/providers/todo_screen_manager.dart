import 'dart:math';

import 'package:flutter/material.dart';

import '../../resources/data/models.dart';
import '../../resources/validators/validators.dart';

class TodoScreenManager extends ChangeNotifier {
  final Todo _currentTodo;
  final textController = TextEditingController();
  String? errorText;

  TodoScreenManager(Todo? originalTodo)
      : _currentTodo = originalTodo ??
            Todo(
              id: (Random().nextDouble() * 10000).round(),
              name: "",
              dueDate: DateTime.now(),
            );

  Todo get currentTodo => _currentTodo;

  void upDateTodoName(String name) {
    _currentTodo.name = name;
  }

  void updateColor(Color color) {
    _currentTodo.color = color;
  }

  void updateDueDate(DateTime dateTime) {
    _currentTodo.dueDate = dateTime;
  }

  void updateDueTime(TimeOfDay timeOfDay) {
    _currentTodo.dueTime = timeOfDay;
  }

  void updateLevel(Level level) {
    _currentTodo.level = level;
    notifyListeners();
  }

  bool validateTaskConfig() {
    print("hello" + _currentTodo.name);
    if (!TaskValidator.isValidName(_currentTodo.name)) {
      errorText = "Invalid name";
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }
}
