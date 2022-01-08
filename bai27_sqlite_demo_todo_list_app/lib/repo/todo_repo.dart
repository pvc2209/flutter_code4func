import 'package:bai27_sqlite_demo_todo_list_app/db/todo_table.dart';
import 'package:bai27_sqlite_demo_todo_list_app/model/todo.dart';
import 'package:bai27_sqlite_demo_todo_list_app/service/todo_service.dart';

class TodoRepo {
  final TodoTable _todoTable = TodoTable();
  final TodoService _todoService = TodoService();

  Future<int> insertTodo(Todo todo) {
    return _todoTable.insertTodo(todo);
  }

  Future<void> deleteTodo(Todo todo) {
    return _todoTable.deleteTodo(todo);
  }

  Future<List<Todo>> selectAllTodo() {
    return _todoTable.selectAllTodo();
  }

  Future<List<Todo>> initData() async {
    List<Todo> data = <Todo>[];

    data = await _todoTable.selectAllTodo();

    if (data.isEmpty) {
      return await _todoService.getTodoList();
    }

    return data;
  }
}
