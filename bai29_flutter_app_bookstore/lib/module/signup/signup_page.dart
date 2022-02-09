import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/base/base_widget.dart';
import 'package:bai29_flutter_app_bookstore/data/remote/user_service.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/user_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_event.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_fail_event.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_success_event.dart';
import 'package:bai29_flutter_app_bookstore/module/home/home_page.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/app_color.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/bloc_listener.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/loading_task.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/normal_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signup_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: "Sign Up",
      bloc: const [],
      di: [
        Provider<UserService>(
          create: (context) => UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) => UserRepo(
            userService: userService,
          ),
        ),
      ],
      child: const SignUpFormWidget(),
    );
  }
}

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final _txtDisplayNameController = TextEditingController();
  final _txtPhoneController = TextEditingController();
  final _txtPassController = TextEditingController();

  void handleEvent(BaseEvent event) {
    if (event is SignUpSuccessEvent) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        ModalRoute.withName("/home"),
      );
      return;
    }

    if (event is SignUpFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _txtDisplayNameController.dispose();
    _txtPhoneController.dispose();
    _txtPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        userRepo: Provider.of<UserRepo>(context, listen: false),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Consumer<SignUpBloc>(
          builder: (context, bloc, child) => BlocListener<SignUpBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDisplayNameField(bloc),
                  _buildPhoneField(bloc),
                  _buildPassField(bloc),
                  _buildSignUpButton(bloc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayNameField(SignUpBloc bloc) {
    return StreamProvider(
      initialData: "",
      create: (context) => bloc.displayNameStream,
      child: Consumer<String>(
        builder: (context, message, child) => Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: TextField(
            onChanged: (text) {
              bloc.displayNameSink.add(text);
            },
            controller: _txtDisplayNameController,
            cursorColor: Colors.black,
            // keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              errorText: message.isEmpty ? null : message,
              icon: Icon(
                Icons.account_box,
                color: AppColor.blue,
              ),
              hintText: "Display name",
              labelText: "Display name",
              labelStyle: TextStyle(
                color: AppColor.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(SignUpBloc bloc) {
    return StreamProvider(
      initialData: "",
      create: (context) => bloc.phoneStream,
      child: Consumer<String>(
        builder: (context, message, child) => Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: TextField(
            onChanged: (text) {
              bloc.phoneSink.add(text);
            },
            controller: _txtPhoneController,
            cursorColor: Colors.black,
            // keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              errorText: message.isEmpty ? null : message,
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
        ),
      ),
    );
  }

  Widget _buildPassField(SignUpBloc bloc) {
    return StreamProvider(
      initialData: "",
      create: (context) => bloc.passStream,
      child: Consumer<String>(
        builder: (context, message, child) => Container(
          margin: const EdgeInsets.only(bottom: 25.0),
          child: TextField(
            onChanged: (text) {
              bloc.passSink.add(text);
            },
            controller: _txtPassController,
            obscureText: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              errorText: message.isEmpty ? null : message,
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
        ),
      ),
    );
  }

  Widget _buildSignUpButton(SignUpBloc bloc) {
    return StreamProvider<bool>(
      initialData: false,
      create: (context) => bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => NormalButton(
          title: "Sign Up",
          onPressed: enable
              ? () {
                  bloc.event.add(SignUpEvent(
                    displayName: _txtDisplayNameController.text,
                    phone: _txtPhoneController.text,
                    pass: _txtPassController.text,
                  ));
                }
              : null,
        ),
      ),
    );
  }
}
