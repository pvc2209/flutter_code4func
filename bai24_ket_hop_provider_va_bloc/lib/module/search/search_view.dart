import 'package:flutter/material.dart';

import 'search_bloc.dart';
import 'search_box.dart';
import 'search_result.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SearchBox(),
          Expanded(
            child: Result(),
          ),
        ],
      ),
    );
  }
}
