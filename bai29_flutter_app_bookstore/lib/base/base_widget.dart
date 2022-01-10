import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;

  // SingleChildCloneableWidget đã bị đổi thành SingleChildWidget
  // SingleChildWidget là 1 class của provider, để truyền vào MultiProvider ở bên dưới,
  // các phần tử của list này là các state model như là Counter chẳng hạn...
  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di;

  const PageContainer({
    Key? key,
    required this.title,
    required this.child,
    required this.bloc,
    required this.di,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: AppColor.blue),
        ),
      ),
      // Tạm thời remove multiprovider thì mới chạy được
      // vì list truyền vào cần it nhất 1 phần tử
      body: child,
    );
  }
}
