import 'package:bai27_sqlite_demo_todo_list_app/bloc/todo_bloc.dart';
import 'package:bai27_sqlite_demo_todo_list_app/event/add_todo_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Sử dụng StatefulWidget khi dùng TextEditingController
// vì StatefulWidget cung cấp 2 hàm là initState, và dispose
class TodoHeader extends StatefulWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  State<TodoHeader> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends State<TodoHeader> {
  final txtTodoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // txtTodoController.addListener(() {
    //   print(txtTodoController.text);
    // });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    txtTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TodoBloc>(context);

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: txtTodoController,
            decoration: const InputDecoration(
              labelText: "Add todo",
              hintText: "Add todo",
            ),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {
            bloc.event.add(AddTodoEvent(txtTodoController.text));
          },
          icon: const Icon(Icons.add),
          label: const Text("Add"),
        )
      ],
    );
  }
}
