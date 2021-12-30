import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Lưu ý: Nếu không dùng ChangeNotifierProvider mà dùng kiểu
// Provider<Counter3>.value(value: Counter3());
// Thì class Counter3 không cần phải with ChangeNotifier và notifyListeners(); nữa
// Nhưng doc của Provider nó là không dùng Provider.value

class Counter3 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
  }
}

class Counter1 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class Counter2 with ChangeNotifier {
  int _count = 10;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class DemoMultipleProvider extends StatelessWidget {
  const DemoMultipleProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter1()),
        ChangeNotifierProvider(create: (_) => Counter2()),
        // Provider<Counter3>.value(value: Counter3());
      ],
      child: const TestWidget1(),
    );
  }
}

class TestWidget1 extends StatelessWidget {
  const TestWidget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Counter1 counter1 = Provider.of<Counter1>(context);
    Counter2 counter2 = Provider.of<Counter2>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Counter1: ${counter1.count}",
            style: const TextStyle(fontSize: 30),
          ),
          Text(
            "Counter2: ${counter2.count}",
            style: const TextStyle(fontSize: 30),
          ),
          ElevatedButton(
            onPressed: () {
              counter1.increment();
              counter2.increment();
            },
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
