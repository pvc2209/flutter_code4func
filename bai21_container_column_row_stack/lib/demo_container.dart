import 'package:flutter/material.dart';

class DemoContainer extends StatelessWidget {
  const DemoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Container"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(30),
        width: 200,
        height: 200,
        color: Colors.pink,
        child: const Text(
          "Container",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
