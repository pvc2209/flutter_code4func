import 'package:bai22_provider/basic.dart';
import 'package:bai22_provider/demo_change_notifier.dart';
import 'package:bai22_provider/demo_future_provider.dart';
import 'package:bai22_provider/demo_multiple_provider.dart';
import 'package:bai22_provider/demo_proxy_provider.dart';
import 'package:bai22_provider/demo_stream_provider.dart';
import 'package:bai22_provider/demo_value_listenable_provider.dart';
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
          title: const Text("Demo Provider"),
        ),
        // body: const BasicProvider(),
        // body: const DemoChangeNotifierProvider(),
        // body: const DemoMultipleProvider(),
        // body: const DemoValueListenableProvider(),
        // body: const DemoProxyProvider(),
        // body: const DemoFutureProvider(),
        body: const DemoStreamProvider(),
      ),
    );
  }
}
