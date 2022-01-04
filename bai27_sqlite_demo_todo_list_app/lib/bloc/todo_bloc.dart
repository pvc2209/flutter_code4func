import 'dart:async';
import 'dart:math';

import 'package:bai27_sqlite_demo_todo_list_app/base/base_bloc.dart';
import 'package:bai27_sqlite_demo_todo_list_app/base/base_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/event/add_todo_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/event/delete_todo_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/model/todo.dart';

class TodoBloc extends BaseBloc {
  final StreamController<List<Todo>> _todoListStreamController =
      StreamController();

  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;

  final _listTodoData = <Todo>[];

  final _randomInt = Random();

  void _addTodo(Todo todo) {
    _listTodoData.add(todo);
    _todoListStreamController.sink.add(_listTodoData);
  }

  void _deleteTodo(Todo todo) {
    _listTodoData.remove(todo);
    _todoListStreamController.sink.add(_listTodoData);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      Todo todo = Todo.fromData(
        _randomInt.nextInt(1000000),
        event.content,
      );

      _addTodo(todo);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _todoListStreamController.close();
  }
}
