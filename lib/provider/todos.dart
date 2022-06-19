import 'package:flutter/cupertino.dart';

import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan family trip to Norway',
      description: '''- Rent some hotels
- Rent a car
- Pack suitcase''',
      timer: '3',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog 🐕',
      timer: '5',
    ),
    Todo(
        createdTime: DateTime.now(),
        title: 'Plan Jacobs birthday party 🎉🥳',
        timer: '8'),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String timer, String description) {
    todo.title = title;
    todo.description = description;
    todo.timer = timer;
    notifyListeners();
  }
}
