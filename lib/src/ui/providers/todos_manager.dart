import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/resources/data/models.dart';

enum Categories {
  all,
  today,
  completed,
}

class TodoManager extends ChangeNotifier {
  final List<Todo> _todos = <Todo>[];

  Categories _selectedCategory = Categories.all;

  Categories get selectedCategory => _selectedCategory;

  void selectCategory(Categories category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Todo> get selectedTodos {
    if (_selectedCategory == Categories.completed) {
      return _todos.where((element) => element.isComplete).toList();
    } else if (_selectedCategory == Categories.today) {
      final now = DateTime.now();
      final nextDay = DateTime(now.year, now.month, now.day + 1);
      return _todos
          .where((todo) =>
              todo.dueDate.difference(nextDay) < const Duration(days: 1))
          .toList();
    } else {
      return _todos;
    }
  }

  void upDateTodo(int id, Todo newTodo) {
    int index = _todos.indexWhere((element) => element.id == id);
    _todos[index] = newTodo.copyWith(id: id);
    notifyListeners();
  }

  void addTodo(Todo newTodo) {
    _todos.add(newTodo);
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    _todos.removeAt(index);
    notifyListeners();
  }

  void completeTodo(Todo todo, bool? isCompleted) {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index].setFinished(isCompleted);
    notifyListeners();
  }
}
