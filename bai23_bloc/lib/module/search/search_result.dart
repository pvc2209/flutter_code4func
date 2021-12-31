import 'package:flutter/material.dart';

import 'search_bloc.dart';

class Result extends StatefulWidget {
  final SearchBloc bloc;

  const Result({Key? key, required this.bloc}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<String>>(
        initialData: const [],
        stream: widget.bloc.searchController.stream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) => _buildRow(
              snapshot.data![index],
            ),
          );
        },
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
