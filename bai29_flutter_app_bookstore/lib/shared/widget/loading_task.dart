import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'scale_animation.dart';

class LoadingTask extends StatelessWidget {
  final Widget child;
  final BaseBloc bloc;

  const LoadingTask({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>(
      initialData: false,
      create: (context) => bloc.loadingStream,
      child: Stack(
        children: [
          child,
          Consumer<bool>(
            builder: (context, isLoading, child) => Center(
              child: isLoading
                  ? ScaleAnimation(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: const SpinKitPouringHourGlass(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}
