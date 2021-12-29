import 'package:flutter/material.dart';

class DemoStack extends StatelessWidget {
  const DemoStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Container"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 100,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
          Positioned(
            top: 100,
            left: 150,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          ),
          Positioned(
            top: 150,
            left: 200,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
