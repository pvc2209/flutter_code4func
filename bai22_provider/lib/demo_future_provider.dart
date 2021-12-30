import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoFutureProvider extends StatelessWidget {
  const DemoFutureProvider({Key? key}) : super(key: key);

  Future<int> getAge() {
    return Future<int>.delayed(const Duration(seconds: 2), () => 500);
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<int>(
      create: (_) => getAge(),
      initialData: 10,
      child: const DemoFutureWidget(),
    );
  }
}

class DemoFutureWidget extends StatelessWidget {
  const DemoFutureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<int>(
      builder: (context, value, child) => Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
