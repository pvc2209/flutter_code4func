import 'package:flutter/material.dart';

import 'search_bloc.dart';

class SearchBox extends StatefulWidget {
  final SearchBloc bloc;

  const SearchBox({Key? key, required this.bloc}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      var query = searchController.text;

      widget.bloc.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search),
        hintText: "Search...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
