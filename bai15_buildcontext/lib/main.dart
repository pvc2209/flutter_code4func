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
      home: const DemoBuildContext(),
    );
  }
}

class DemoBuildContext extends StatelessWidget {
  const DemoBuildContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo BuildContext"),
        centerTitle: true,
      ),
      body: Center(
        child: OngBa(
          child: ChaMe(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ConTrai(),
                ConGai(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OngBa extends StatelessWidget {
  final Widget child;

  const OngBa({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class ChaMe extends StatelessWidget {
  final Widget child;

  const ChaMe({Key? key, required this.child}) : super(key: key);

  String layTenConTrai() {
    return "Cuong";
  }

  String layTenConGai() {
    return "Mai";
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class ConTrai extends StatelessWidget {
  const ConTrai({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChaMe? chaMe = context.findAncestorWidgetOfExactType<ChaMe>();

    return Text(
      chaMe?.layTenConTrai() ?? "Con trai mồ côi cha mẹ😢",
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}

class ConGai extends StatelessWidget {
  const ConGai({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChaMe? chaMe = context.findAncestorWidgetOfExactType<ChaMe>();

    return Text(
      chaMe?.layTenConGai() ?? "Con gái mồ côi cha mẹ😢",
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
