import 'package:flutter/material.dart';

class Demo2 extends StatefulWidget {
  const Demo2({Key? key}) : super(key: key);

  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // MyText(),
          _count % 2 == 0
              ? MyText(
                  key: ObjectKey("123"),
                )
              : MyText(
                  key: ObjectKey("123"),
                ),
          Text(
            "$_count",
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            onPressed: _increment,
            child: const Text(
              "Increment",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyText extends StatefulWidget {
  const MyText({Key? key}) : super(key: key);

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  // Được call khi "widget cha" bị rebuild và widget MyText có cùng RuntimeType
  // và key (nếu vẫn là MyText mà khác key thì didUpdateWidget sẽ không được gọi)
  @override
  void didUpdateWidget(covariant MyText oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Container();
  }
}
