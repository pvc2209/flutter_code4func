import 'dart:async';

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
        body: FutureWidget(),
      ),
    );
  }
}

class FutureWidget extends StatefulWidget {
  const FutureWidget({Key? key}) : super(key: key);

  @override
  _FutureWidgetState createState() => _FutureWidgetState();
}

// Demo cách sử dụng StreamBuilder thông qua 1 stream bình thường (stream từ hàm streamData())
// hoặc qua StreamController (timmerStreamController)
class _FutureWidgetState extends State<FutureWidget> {
  StreamController<String> timmerStreamController = StreamController();

  @override
  void initState() {
    super.initState();

    initStream();
  }

  Stream<String> streamData() {
    return Stream<String>.periodic(const Duration(seconds: 1), (value) {
      return value.toString();
    });
  }

  void initStream() {
    Stream.periodic(const Duration(seconds: 1), (value) {
      return value;
    }).take(10).listen((value) {
      timmerStreamController.sink.add(value.toString());

      if (value == 9) {
        timmerStreamController.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: timmerStreamController.stream,
              // stream: streamData(),
              // stream: streamData().take(10),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 30),
                  );
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text("Not connected to Stream or null");
                  case ConnectionState.waiting:
                    return const Text("Waiting interaction");
                  case ConnectionState.active:
                    return Text(
                      snapshot.data.toString(),
                      style: const TextStyle(fontSize: 30),
                    );
                  case ConnectionState.done:
                    return const Text("Stream has finished");
                  default:
                    return const Text("Default??");
                }
              })
        ],
      ),
    );
  }
}
