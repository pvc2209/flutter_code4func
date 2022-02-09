import 'dart:async';

import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/user_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_event.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_fail_event.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_success_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BaseBloc {
  // BehaviorSubject là 1 class của thư viện rxdart
  // tương đương streamController mà thôi (vì nó kế thừa từ StreamController)
  // các BehaviorSubject giúp gửi thông tin ngược lại cho widget
  final _displayNameSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  final UserRepo _userRepo;

  SignUpBloc({required UserRepo userRepo}) : _userRepo = userRepo {
    validateForm();
  }

  var displayNameVaidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (displayName, sink) {
    if (Validation.isDisplayNameValid(displayName)) {
      sink.add("");
      return;
    }

    sink.add("Display name too short");
  });

  var phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (Validation.isPhoneValid(phone)) {
      sink.add("");
      return;
    }

    sink.add("Phone Invalid");
  });

  var passValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (Validation.isPassValid(pass)) {
      sink.add("");
      return;
    }

    sink.add("Password too short");
  });

  Stream<String> get displayNameStream =>
      _displayNameSubject.transform(displayNameVaidation);

  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);

  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passValidation);

  Sink<String> get displayNameSink => _displayNameSubject.sink;
  Sink<String> get passSink => _passSubject.sink;
  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  void validateForm() {
    // Rx.combineLatest2: Merges the given Streams into a single Stream sequence by using the [combiner] function whenever any of the stream sequences emits an item.
    // The Stream will not emit until all streams have emitted at least one item.
    // => rxdart hay đó

    Rx.combineLatest3(_displayNameSubject, _phoneSubject, _passSubject,
        (String displayName, String phone, String pass) {
      return Validation.isDisplayNameValid(displayName) &&
          Validation.isPhoneValid(phone) &&
          Validation.isPassValid(pass);
    }).listen((enable) {
      // cái stream vừa được combine sẽ được listen luôn, để phát event cho btnSink
      btnSink.add(enable);
    });
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignUpEvent:
        handleSignUp(event as SignUpEvent);
        break;
    }
  }

  void handleSignUp(SignUpEvent event) {
    btnSink.add(false);
    loadingSink.add(true);

    _userRepo.signUp(event.displayName, event.phone, event.pass).then(
      (userData) {
        processEventSink.add(SignUpSuccessEvent(userData));
      },
      onError: (e) {
        loadingSink.add(false);

        processEventSink.add(SignUpFailEvent(e.toString()));

        btnSink.add(true);
      },
    );
  }

  @override
  void dispose() {
    _displayNameSubject.close();
    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();

    super.dispose();
  }
}
