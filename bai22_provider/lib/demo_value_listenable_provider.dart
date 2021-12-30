import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter {
  final ValueNotifier<int> valueNotifier = ValueNotifier(10);
}

class DemoValueListenableProvider extends StatelessWidget {
  const DemoValueListenableProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<Counter>(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, counter, child) {
          return ValueListenableProvider<int>.value(
            // counter.valueNotifier vày khi bị thay đổi thì nó sẽ tự rebuild lại
            //những widget đang lắng nghe nó mà không cần gọi hàm notifyListeners();
            // như ở ví dụ này chỉ có 2 widget bị rebuild là
            // Consumer<int> và ElevatedButton
            value: counter.valueNotifier,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  DemoConsumerWidget(),
                  OtherWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DemoConsumerWidget extends StatelessWidget {
  const DemoConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<int>(
      builder: (context, value, child) {
        print("rebuild Consumer");

        return Text(
          value.toString(),
          style: const TextStyle(fontSize: 30),
        );
      },
    );
  }
}

class OtherWidget extends StatelessWidget {
  const OtherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final counter = Provider.of<Counter>(context);

    return ElevatedButton(
      onPressed: () {
        final counter = Provider.of<Counter>(context, listen: false);
        counter.valueNotifier.value++;
      },
      child: const Text("Increment"),
    );
  }
}
