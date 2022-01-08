import 'package:bai27_sqlite_demo_todo_list_app/model/todo.dart';

// TodoService làm việc với network
class TodoService {
  Future<List<Todo>> getTodoList() async {
    return [
      Todo.fromData(1, "content 1"),
      Todo.fromData(2, "content 2"),
    ];
  }
}
