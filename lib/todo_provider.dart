import 'package:flutter/material.dart';

import 'todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    final newTodo = Todo(title: title);
    _todos.add(newTodo);
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void removeCompletedTodos() {
    _todos.removeWhere((todo) => todo.isDone);
    notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
