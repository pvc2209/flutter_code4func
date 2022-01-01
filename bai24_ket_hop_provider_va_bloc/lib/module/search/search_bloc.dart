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

    // _filter(query).then(
    //   (result) => searchController.sink.add(result),
    // );

    // Theo suy luận thì đoạn loop qua list data đó chả có lý do gì mà phải
    // dù future cả vì nếu list có kích thước lớn vẫn block UI như thường
    // Đã test với list data 100000 phần tử
    searchController.sink.add(_filter2(query));
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
