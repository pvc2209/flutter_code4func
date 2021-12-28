import 'package:flutter/material.dart';

class Demo3 extends StatefulWidget {
  const Demo3({Key? key}) : super(key: key);

  @override
  _Demo3State createState() => _Demo3State();
}

class _Demo3State extends State<Demo3> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Mỗi khi ShareDataWidget(InhertedWidget) bị rebuild
      // thì những widget được bọc bởi InheritedWidget sẽ bị rebuild
      // nếu hàm updateShouldNotify return true

      // Ở đây nếu ShareDataWidget bị rebuild _increment thì
      // TestDidChangeDependenciesWidget cũng sẽ bị rebuild và
      // hàm didChangeDependencies cũng sẽ được gọi.
      child: ShareDataWidget(
        data: _count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TestDidChangeDependenciesWidget(),
            ElevatedButton(
              onPressed: _increment,
              child: const Text(
                "Increment",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestDidChangeDependenciesWidget extends StatefulWidget {
  const TestDidChangeDependenciesWidget({Key? key}) : super(key: key);

  @override
  _TestDidChangeDependenciesWidgetState createState() =>
      _TestDidChangeDependenciesWidgetState();
}

class _TestDidChangeDependenciesWidgetState
    extends State<TestDidChangeDependenciesWidget> {
  // _TestDidChangeDependenciesWidgetState đang lắng nghe ShareDataWidget(InheritedWidget)
  // Nếu ShareDataWidget bị rebuild thì _TestDidChangeDependenciesWidgetState
  // sẽ bị gọi hàm didChangeDependencies và rebuild
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependencies change");
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      ShareDataWidget.of(context)?.data.toString() ?? "Error",
      style: const TextStyle(fontSize: 20),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data;

  ShareDataWidget({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  // Cái hàm static này là viết sẵn ra để dùng cho tiện thôi
  // Như ở bài 17 thì ở mỗi hàm build khi cần lấy ra InheritedWidget
  // thì ta phải viết là:
  // ShareDataWidget demo = context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();

  // Khi dùng context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  // nó chính là chỗ sẽ Widget sẽ register với InheritedWidget để lắng ngay thay
  // đổi của InheritedWidget. Ở dòng 73 chỗ Text(ShareDataWidget.of(context)?.data.toString() ?? "Error",
  // context ở đó chính là context của _TestDidChangeDependenciesWidgetState
  // nên _TestDidChangeDependenciesWidgetState đã đăng ký (register) với ShareDataWidget
  // di chuột vào hàm dependOnInheritedWidgetOfExactType đọc docs là thấy :D

  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }
}
