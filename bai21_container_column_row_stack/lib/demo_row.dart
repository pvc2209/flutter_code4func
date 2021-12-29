import 'package:flutter/material.dart';

class DemoRow extends StatelessWidget {
  const DemoRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Container"),
        centerTitle: true,
      ),
      body: Row(
        children: const [
          // Khi không đủ chỗ cho text hiển thị thì nếu ta wrap Text
          // bởi Expanded thì text sẽ tự xuống dòng
          Expanded(child: Text("Text 1", style: TextStyle(fontSize: 40))),
          Expanded(child: Text("Text 2", style: TextStyle(fontSize: 40))),
          Expanded(child: Text("Text 3", style: TextStyle(fontSize: 40))),
          Expanded(child: Text("Text 4", style: TextStyle(fontSize: 40))),
        ],
      ),
    );
  }
}
