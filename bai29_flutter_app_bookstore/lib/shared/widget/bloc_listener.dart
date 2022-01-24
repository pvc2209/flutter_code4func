import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/module/signin/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlocListener<T extends BaseBloc> extends StatefulWidget {
  final Widget child;
  final Function(BaseEvent event) listener;

  const BlocListener({Key? key, required this.child, required this.listener})
      : super(key: key);

  @override
  State<BlocListener> createState() => _BlocListenerState<T>();
}

class _BlocListenerState<T> extends State<BlocListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var bloc = Provider.of<T>(context, listen: false) as BaseBloc;

    bloc.processEventStream.listen((event) {
      widget.listener(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Chỗ này cần ? thì initialData mới có thể null được
    return StreamProvider<BaseEvent?>(
      initialData: null,
      create: (context) => (Provider.of<T>(context, listen: false) as BaseBloc)
          .processEventStream,
      updateShouldNotify: (previous, current) => false, // Quan trọng
      child: Consumer<BaseEvent?>(
        builder: (context, value, child) => widget.child,
      ),
    );
  }
}
