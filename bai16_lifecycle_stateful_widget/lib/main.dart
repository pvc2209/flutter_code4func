import 'package:flutter/material.dart';

import 'demo_did_change_dependencies.dart';
import 'demo_did_update_widget.dart';

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
      home: const Scaffold(
        body: Demo3(),
      ),
    );
  }
}

class Demo1 extends StatefulWidget {
  const Demo1({Key? key}) : super(key: key);

  @override
  _Demo1State createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> {
  int _count = 0;

  void _increment() {
    // setState(() {
    //   _count++;
    // });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Demo2(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  // Khi Widget Demo1 bị rebuild khi bấm nút Increment thì didUpdateWidget
  // không được gọi còn vì sao thì xem MyText ở Demo2
  @override
  void didUpdateWidget(covariant Demo1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$_count",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          ElevatedButton(
              onPressed: _increment,
              child: Text(
                "Increment",
                style: TextStyle(
                  fontSize: 30,
                ),
              ))
        ],
      ),
    );
  }
}
