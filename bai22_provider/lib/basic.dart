import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User {
  // Không extends of with ChangeNotifier - ví dụ demo_change_notifier mới dùng
  late String _name;

  String get name => _name;
  set name(String newName) => _name = newName;
}

class BasicProvider extends StatelessWidget {
  const BasicProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = User();
    user.name = "pvc";

    // Không dùng Provider.value() như trong bài mẫu vì trong doc của provider có nói
    // DON'T use Provider.value to create your object.
    return Provider<User>(
      create: (context) => user,
      child: BasicWidget(),
    );
  }
}

class BasicWidget extends StatelessWidget {
  const BasicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // Có 2 cách để lấy dữ liệu được chia sẻ từ Provider
        DemoConsumerWidget(),
        DemoWithoutConsumerWidget(),
      ],
    );
  }
}

class DemoConsumerWidget extends StatelessWidget {
  const DemoConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) => Text(user.name),
    );
  }
}

class DemoWithoutConsumerWidget extends StatelessWidget {
  const DemoWithoutConsumerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Container(
      child: Text(user.name),
    );
  }
}
