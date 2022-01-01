import 'package:bai24_ket_hop_provider_va_bloc/module/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'module/search/search_view.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Demo BLoC"),
        ),
        body: Provider<SearchBloc>(
          create: (context) => SearchBloc(),
          child: SearchView(),
        ),
      ),
    );
  }
}
