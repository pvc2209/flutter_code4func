import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  final Widget child;

  const MyContainer({Key? key, required this.child}) : super(key: key);

  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  int data = 0;

  void increament() {
    setState(() {
      data++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DemoInheritedWidget2(
      state: this,
      child: widget.child,
    );
  }
}

class DemoInheritedWidget2 extends InheritedWidget {
  // Việc viết thêm 1 thuộc tính Widget child; ở đây là không cần thiêt
  // vì class super của nó đã có thuộc tính child rồi, ta đã truyền child đó vào
  // super(child: child)
  // nếu cần lấy child ra dùng thì cứ dùng y như state thôi
  final _MyContainerState state;

  const DemoInheritedWidget2({Key? key, required this.state, required child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DemoInheritedWidget2? demo =
        context.dependOnInheritedWidgetOfExactType<DemoInheritedWidget2>();

    return Center(
      child: Column(
        children: [
          Text(
            "${demo?.state.data}",
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            onPressed: demo?.state.increament,
            child: const Text("Increment"),
          ),
        ],
      ),
    );
  }
}
