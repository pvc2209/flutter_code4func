import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  // SingleChildCloneableWidget đã bị đổi thành SingleChildWidget
  // SingleChildWidget là 1 class của provider, để truyền vào MultiProvider ở bên dưới,
  // các phần tử của list này là các state model như là Counter chẳng hạn...
  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di; // di là viết tắt của dependency inject

  const PageContainer({
    Key? key,
    required this.title,
    required this.child,
    required this.bloc,
    required this.di,
    this.actions,
  }) : super(key: key);

  // Lúc trước MultiProvider không hoạt động được không phải là do di, bloc
  // chưa có các phần tử mà là do child chưa được gán,
  // chả hiểu sao lúc ấy không gán child: child mà view vẫn hiển thị lên :v
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: AppColor.blue),
        ),
        actions: actions,
      ),
      body: MultiProvider(
        providers: [
          ...di,
          ...bloc,
        ],
        child: child,
      ),
    );
  }
}

// class này có vẻ thừa
/* class NavigatorProvider extends StatelessWidget {
  const NavigatorProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [],
      ),
    );
  }
}
 */