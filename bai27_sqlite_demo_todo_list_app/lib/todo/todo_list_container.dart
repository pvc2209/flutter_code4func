import 'package:flutter/material.dart';

import 'todo_header.dart';
import 'todo_list.dart';

class TodoListContainer extends StatelessWidget {
  const TodoListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            TodoHeader(),
            TodoList(),
          ],
        ),
      ),
    );
  }
}
