import 'package:bai27_sqlite_demo_todo_list_app/db/todo_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static const DB_NAME = "todo.db";
  static const DB_VERSION = 1;
  static late Database _database;

  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();

  Database get database => _database;

  // Khi có nhiều bảng thì nên lưu các câu query của từng bảng lại dùng cho nó
  // chuyên nghiệp - Xem video lúc 1h25
  static const initScripts = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [TodoTable.CREATE_TABLE_QUERY];

  Future<void> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        initScripts.forEach((script) async {
          await db.execute(script);
        });
      },
      onUpgrade: (db, oldVersion, newVersion) {
        migrationScripts.forEach((script) async {
          await db.execute(script);
        });
      },
      version: DB_VERSION,
    );
  }
}
