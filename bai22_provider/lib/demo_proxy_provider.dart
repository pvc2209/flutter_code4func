import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// CounterApi được tiêm vào CounterService
// CounterService lại được tiêm vào CounterModel

class CounterApi {
  final int _count = 100;

  int get count => _count;
}

class CounterService {
  final CounterApi _api;

  CounterService({required CounterApi api}) : _api = api;

  CounterApi get api => _api;
}

class CounterModel with ChangeNotifier {
  final CounterService _counterService;

  CounterModel({required CounterService counterService})
      : _counterService = counterService;

  CounterService get counterService => _counterService;
}

class DemoProxyProvider extends StatelessWidget {
  const DemoProxyProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Ở đây dùng Provider mà không dùng ChangeNotifierProvider như ở
        // demo_multiple_provider vì CounterApi không with ChangeNotifier
        Provider(create: (_) => CounterApi()),

        // CounterApi() này sẽ được truyền vào ProxyProvider ở dưới
        // Chúng ta sẽ tiêm (inject) vào ProxyProvider 1 cái CounterApi
        // Sau đó sẽ return về 1 cái mới là CounterService
        // ProxyProvider là cái đứng giữa CounterApi và CounterService,
        // do nó đứng nữa nên mới đc gọi là proxy
        ProxyProvider<CounterApi, CounterService>(
          update: (context, counterApi, previous) =>
              CounterService(api: counterApi),
        ),
      ],
      child: const TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var api = Provider.of<CounterApi>(context);
    // print(api.count);

    return ChangeNotifierProvider<CounterModel>(
      create: (context) => CounterModel(
        counterService: Provider.of<CounterService>(context, listen: false),
      ),
      // CTRL + SPACE để tự điền tham số
      child: Consumer<CounterModel>(
        builder: (context, model, child) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.counterService.api.count.toString(),
                style: const TextStyle(
                  fontSize: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
