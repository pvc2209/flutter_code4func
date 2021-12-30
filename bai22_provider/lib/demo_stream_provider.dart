import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoStreamProvider extends StatelessWidget {
  const DemoStreamProvider({Key? key}) : super(key: key);

  Stream<int> getAge() {
    return Stream.periodic(const Duration(seconds: 1), (value) => value)
        .take(10);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<int>(
      create: (_) => getAge(),
      initialData: 10,
      child: const DemoStreamWidget(),
    );
  }
}

class DemoStreamWidget extends StatelessWidget {
  const DemoStreamWidget({Key? key}) : super(key: key);

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
