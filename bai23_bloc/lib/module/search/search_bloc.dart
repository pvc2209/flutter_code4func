import 'dart:async';

class SearchBloc {
  var data = [
    "Android",
    "iOS",
    "Cpp",
    "Python",
    "Flutter",
    "Dart",
    "Java",
    "Php",
    "Swift",
    "Golang",
  ];

  // StreamController cho phép thêm dữ liệu vào stream
  var searchController = StreamController<List<String>>();

  void search(String query) {
    if (query.isEmpty) {
      searchController.sink.add(data);
      return;
    }

    _filter(query).then(
      (result) => searchController.sink.add(result),
    );

    // Dùng kiểu bình thường vẫn được mà, tại sao phải dùng Future làm gì nhỉ?
    // searchController.sink.add(_filter2(query));
  }

  List<String> _filter2(String query) {
    List<String> result = [];

    for (var element in data) {
      if (element.contains(query)) {
        result.add(element);
      }
    }

    return result;
  }

  Future<List<String>> _filter(String query) {
    var c = Completer<List<String>>();

    List<String> result = [];

    for (var element in data) {
      if (element.contains(query)) {
        result.add(element);
      }
    }

    c.complete(result);
    return c.future;
  }

  void dispose() {
    searchController.close();
  }
}
