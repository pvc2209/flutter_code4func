import 'package:bai27_sqlite_demo_todo_list_app/bloc/todo_bloc.dart';
import 'package:bai27_sqlite_demo_todo_list_app/db/todo_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo/todo_list_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoDatabase.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<TodoBloc>(
        create: (context) => TodoBloc(),
        child: const TodoListContainer(),
      ),
    );
  }
}
