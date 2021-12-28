import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Demo(),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              // Dùng để load dữ liệu từ trên mạng hoặc đọc dữ liệu từ bộ nhớ chẳng hạn
              future: delayNumber(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 40),
                  );
                }

                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(fontSize: 40),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
            ElevatedButton(
              child: const Text("Demo Future"),
              // onPressed: () async {
              //   int value = await delayNumber();

              //   print(value);
              // },

              // onPressed: () {
              //   getAge().then((value) => print(value));
              // },

              onPressed: () async {
                try {
                  int value = await delayNumberWithError();
                  print(value);
                } catch (e) {
                  print(e.toString());
                }

                print("123");
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> asyncMethod() {
  return Future.delayed(
    const Duration(seconds: 2),
    () => print("async method"),
  );
}

Future<int> delayNumber() {
  return Future.delayed(const Duration(seconds: 3), () => 100);
}

Future<int> getAge() {
  return Future.delayed(const Duration(seconds: 2), () => 100);
}

Future<int> delayNumberWithError() {
  return Future.delayed(
      const Duration(seconds: 2), () => throw Exception("Co loi xay ra"));
}
