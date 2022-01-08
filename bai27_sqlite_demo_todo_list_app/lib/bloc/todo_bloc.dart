import 'dart:async';
import 'dart:math';

import 'package:bai27_sqlite_demo_todo_list_app/base/base_bloc.dart';
import 'package:bai27_sqlite_demo_todo_list_app/base/base_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/db/todo_table.dart';
import 'package:bai27_sqlite_demo_todo_list_app/event/add_todo_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/event/delete_todo_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/model/todo.dart';

class TodoBloc extends BaseBloc {
  final _todoTable = TodoTable();

  final StreamController<List<Todo>> _todoListStreamController =
      StreamController();

  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;

  var _todoListData = <Todo>[];

  final _randomInt = Random();

  void initData() async {
    _todoListData = await _todoTable.selectAllTodo();

    _todoListStreamController.sink.add(_todoListData);
  }

  void _addTodo(Todo todo) async {
    // insert to db
    await _todoTable.insertTodo(todo);

    _todoListData.add(todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  void _deleteTodo(Todo todo) async {
    await _todoTable.deleteTodo(todo);

    _todoListData.remove(todo);
    _todoListStreamController.sink.add(_todoListData);
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
