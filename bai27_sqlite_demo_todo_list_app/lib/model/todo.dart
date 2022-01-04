class Todo {
  late int _id;
  late String _content;

  Todo.fromData(id, content) {
    _id = id;
    _content = content;
  }

  int get id => _id;
  // set id(int value) => _id = value;

  String get content => _content;
  // set content(String value) => _content = value;
}
