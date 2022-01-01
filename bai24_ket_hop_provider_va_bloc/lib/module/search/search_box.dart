import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_bloc.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Không thể lấy bloc ra từ initState
    // do đó đặt trong didChangeDependencies vì didChangeDependencies được
    // gọi ngay sau initState
    var bloc = Provider.of<SearchBloc>(context);

    searchController.addListener(() {
      var query = searchController.text;

      bloc.search(query);
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
