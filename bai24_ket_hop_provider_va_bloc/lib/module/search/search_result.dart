import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_bloc.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBloc>(
      builder: (context, bloc, child) => Container(
        child: StreamBuilder<List<String>>(
          initialData: const [],
          stream: bloc.searchController.stream,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) => _buildRow(
                snapshot.data![index],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRow(String data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Text(
        data,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
