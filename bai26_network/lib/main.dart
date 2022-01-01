import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DemoNetwork(),
    );
  }
}

class DemoNetwork extends StatefulWidget {
  const DemoNetwork({Key? key}) : super(key: key);

  @override
  _DemoNetworkState createState() => _DemoNetworkState();
}

class _DemoNetworkState extends State<DemoNetwork> {
  String message = "";

  // Cách 1: Dùng thư viện http
  void makeHttpGet() async {
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body);
      var post = Post.fromJson(jsonDecode(response.body));

      setState(() {
        message = post.title;
      });
    }
  }

  void makeHttpPost() async {
    // Kiểu 1: Tạo request đơn giản giống với cách GET ở trên
    // Open rồi close request luôn
    /* Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    final response = await http.post(
      url,
      body: {
        "title": "PVC",
        "body": "Learning Flutter at Code4Func",
      },
    );

    // print(response.body);

    if (response.statusCode == 201) {
      // print(response.body);
      var post = Post.fromJson(jsonDecode(response.body));

      setState(() {
        message = post.title;
      });
    } */

    // Kiểu 2: Khi chúng ta thực hiện nhiều request 1 lúc tới cùng server thì
    // việc open-close là không cần thiết, chúng ta có thể tạo 1 client để
    // kết nối đến server và để thực thi request và khi xong việc thì close cái
    // client ấy lại.

    var client = http.Client();
    try {
      Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

      // request lần 1
      final response = await client.post(
        url,
        body: {
          "title": "PVC",
          "body": "Learning Flutter at Code4Func",
        },
      );

      // print(response.body);

      if (response.statusCode == 201) {
        // print(response.body);
        var post = Post.fromJson(jsonDecode(response.body));

        setState(() {
          message = post.title;
        });
      }

      // request lần 2: do sử dụng cùng client do đó tránh việc open-close gây
      // lãng phí tài nguyên như kiểu 1
      final response2 = await client.post(
        url,
        body: {
          "title": "Pham Cuong",
          "body": "Learning Flutter at Code4Func",
        },
      );

      // ...

    } finally {
      client.close();
    }
  }

  // Cách 2: dùng dart:io // Bỏ qua :)

  // Cách 3: dùng thư viện dio : Khuyến khích dùng
  void getHttpWithDio() async {
    try {
      var response =
          await Dio().get("https://jsonplaceholder.typicode.com/posts/1");
      print(response);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              onPressed: () {
                makeHttpGet();
              },
              child: const Text("Make GET request with http"),
            ),
            ElevatedButton(
              onPressed: () {
                makeHttpPost();
              },
              child: const Text("Make POST request with http"),
            ),
            ElevatedButton(
              onPressed: () {
                getHttpWithDio();
              },
              child: const Text("Make Get request with Dio"),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  int? userId;
  final int id;
  final String title;
  final String body;

  Post({
    this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}
