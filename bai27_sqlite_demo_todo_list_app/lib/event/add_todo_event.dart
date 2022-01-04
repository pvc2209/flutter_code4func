import 'package:bai27_sqlite_demo_todo_list_app/base/base_event.dart';

class AddTodoEvent extends BaseEvent {
  String content;

  AddTodoEvent(this.content);
}
