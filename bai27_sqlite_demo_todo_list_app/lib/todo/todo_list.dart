import 'package:bai27_sqlite_demo_todo_list_app/bloc/todo_bloc.dart';
import 'package:bai27_sqlite_demo_todo_list_app/event/delete_todo_event.dart';
import 'package:bai27_sqlite_demo_todo_list_app/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<TodoBloc>(
        builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
            stream: bloc.todoListStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active: // Có dữ liệu đẩy từ stream ra
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Item ${snapshot.data![index].content}"),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red.shade400,
                          ),
                          onPressed: () {
                            bloc.event
                                .add(DeleteTodoEvent(snapshot.data![index]));
                          },
                        ),
                      );
                    },
                  );
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return const Center(
                    child: Text(
                      "Empty",
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                case ConnectionState.done:
                  break;
              }

              return Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: const CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
