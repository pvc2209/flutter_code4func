import 'package:bai29_flutter_app_bookstore/base/base_widget.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/normal_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageContainer(
      title: "Sign In",
      bloc: [],
      di: [],
      child: SignInFormWidget(),
    );
  }
}

// next 27p30
class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPhoneField(),
          _buildPassField(),
          NormalButton(
            onPressed: () {},
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Đăng ký tài khoản",
          style: TextStyle(
            fontSize: 17,
            color: AppColor.blue,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(10.0),
      onTap: () {},
    );
  }

  Widget _buildPhoneField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        cursorColor: Colors.black,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: AppColor.blue,
          ),
          hintText: "(+84) 394773456",
          labelText: "Phone",
          labelStyle: TextStyle(
            color: AppColor.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildPassField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25.0),
      child: TextFormField(
        obscureText: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: AppColor.blue,
          ),
          hintText: "Password",
          labelText: "Password",
          labelStyle: TextStyle(
            color: AppColor.blue,
          ),
        ),
      ),
    );
  }
}
