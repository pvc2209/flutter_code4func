import 'package:bai29_flutter_app_bookstore/shared/style/btn_style.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const NormalButton({Key? key, this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 45),
        primary: AppColor.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        title,
        style: BtnStyle.normal(),
      ),
    );
  }
}
