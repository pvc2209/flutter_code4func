import 'package:bai27_sqlite_demo_todo_list_app/base/base_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  final Todo todo;

  DeleteTodoEvent(this.todo);
}
