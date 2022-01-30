import 'package:bai29_flutter_app_bookstore/module/checkout/checkout_page.dart';
import 'package:bai29_flutter_app_bookstore/module/home/home_page.dart';
import 'package:bai29_flutter_app_bookstore/module/signin/signin_page.dart';
import 'package:bai29_flutter_app_bookstore/module/signup/signup_page.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColor.yellow,
      ),
      // home: const SignInPage(),
      initialRoute: "/",
      routes: {
        "/": (context) => const SignInPage(),
        "/sign-in": (context) => const SignInPage(),
        "/sign-up": (context) => const SignUpPage(),
        "/home": (context) => const HomePage(),
        "/checkout": (context) => const CheckoutPage(),
      },
    );
  }
}
