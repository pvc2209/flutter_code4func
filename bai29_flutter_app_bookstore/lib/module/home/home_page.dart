import 'package:bai29_flutter_app_bookstore/base/base_widget.dart';
import 'package:bai29_flutter_app_bookstore/data/remote/user_service.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: "Home",
      di: [
        Provider<UserService>(
          create: (context) => UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, _) =>
              UserRepo(userService: userService),
        ),
      ],
      bloc: [],
      child: ProductListWidget(),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
