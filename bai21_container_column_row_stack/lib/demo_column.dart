import 'package:flutter/material.dart';

class DemoColumn extends StatelessWidget {
  const DemoColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Container"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize:
            MainAxisSize.min, // Column có kích thước bằng đúng các con

        verticalDirection: VerticalDirection.up, // Column từ dưới lên trên
        children: const [
          Text("Text 1", style: TextStyle(fontSize: 40)),
          Text("Text 2", style: TextStyle(fontSize: 40)),
          Text("Text 3", style: TextStyle(fontSize: 40)),
          Text("Text 4", style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}
