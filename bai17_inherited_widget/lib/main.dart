import 'package:bai17_inherited_widget/demo2.dart';
import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Demo"),
        ),

        // Demo1
        // body: DemoInheritedWidget(
        //   child: OngBa(),
        // ),

        // Demo2
        body: const MyContainer(
          child: Counter(),
        ),
      ),
    );
  }
}

class DemoInheritedWidget extends InheritedWidget {
  int count = 1000;

  DemoInheritedWidget({required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class OngBa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChaMe(),
    );
  }
}

class ChaMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConGai(),
    );
  }
}

class ConGai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DemoInheritedWidget? demo =
        context.dependOnInheritedWidgetOfExactType<DemoInheritedWidget>();

    return Center(
      child: Text(
        "${demo?.count}",
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}
