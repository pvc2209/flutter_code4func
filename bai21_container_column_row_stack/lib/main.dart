import 'package:bai21_container_column_row_stack/demo_column.dart';
import 'package:bai21_container_column_row_stack/demo_row.dart';
import 'package:bai21_container_column_row_stack/demo_stack.dart';
import 'package:flutter/material.dart';

import 'demo_container.dart';

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
        home: DemoStack());
  }
}
