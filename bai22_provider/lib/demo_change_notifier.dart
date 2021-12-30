import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Observer pattern
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class DemoChangeNotifierProvider extends StatelessWidget {
  const DemoChangeNotifierProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: const TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Counter counter = Provider.of<Counter>(context);
    // Có thể dùng Consumer như ở basic.dart

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            counter.count.toString(),
            style: const TextStyle(fontSize: 30),
          ),
          ElevatedButton(
            onPressed: counter.increment,
            child: const Text(
              "Increment",
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
