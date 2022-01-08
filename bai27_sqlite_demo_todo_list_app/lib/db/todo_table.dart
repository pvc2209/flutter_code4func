import 'package:bai27_sqlite_demo_todo_list_app/db/todo_database.dart';
import 'package:bai27_sqlite_demo_todo_list_app/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoTable {
  static const TABLE_NAME = "todo";
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
      id INTEGER PRIMARY KEY,
      content TEXT 
    );
  '''; // Lưu ý: không được có dấu , sau content TEXT

  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';

  Future<int> insertTodo(Todo todo) async {
    final db = TodoDatabase.instance.database;

    return await db.insert(
      TABLE_NAME,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      // Khi insert bị conflict thì chọn cách giải quyết ntn
      // ở đây chọn cách replace
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = TodoDatabase.instance.database;

    await db.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  Future<List<Todo>> selectAllTodo() async {
    final db = TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    return List.generate(maps.length, (index) {
      return Todo.fromData(
        maps[index]["id"],
        maps[index]["content"],
      );
    });
  }
}
