// Luồng dữ liệu sẽ đi như sau:
// PhoneField gửi dữ liệu vào phoneStream thông qua phoneSink.
// nhưng dữ liệu không đi trực tiếp vào phoneStream và nó lại đi
// vào phoneValidation(StreamTransformer),
// rồi StreamTransformer sẽ xử lý cái data đó rồi sẽ phát lại data tới phoneStream
// thông qua cái sink của chính nó (sink của StreamTransformer).

// Mà PhoneField lại đang lắng nghe phoneStream đo đó, nó sẽ nhận được dữ liệu đã
// được xử lý
// Vậy PhoneField vừa phát ra data và vừa nhận data, nhưng data sẽ được xử lý ở trong bloc

import 'dart:async';

import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/user_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/signin_event.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends BaseBloc {
  // BehaviorSubject là 1 class của thư viện rxdart
  // tương đương streamController mà thôi (vì nó kế thừa từ StreamController)
  // các BehaviorSubject giúp gửi thông tin ngược lại cho widget
  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  final UserRepo _userRepo;

  SignInBloc({required UserRepo userRepo}) : _userRepo = userRepo {
    validateForm();
  }

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

  // Để nhận dữ liệu từ stream (lắng nghe sự kiện)
  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);
  // Khi thử xóa .transform(phoneValidation) đi thì dữ liệu không bị transform nữa
  // thì dữ liệu mà PhoneField nhận được cũng chính là dữ liệu nhập vào
  // chứng tỏ PhoneField dùng phoneStream để vừa phát ra data vừa nhận data
  // trên cùng 1 stream. transform(phoneValidation) sẽ là cái đứng giữa để validate data

  // Để đẩy dữ liệu(event) vào stream
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passValidation);

  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  void validateForm() {
    // Rx.combineLatest2: Merges the given Streams into a single Stream sequence by using the [combiner] function whenever any of the stream sequences emits an item.
    // The Stream will not emit until all streams have emitted at least one item.
    // => rxdart hay đó

    Rx.combineLatest2(_phoneSubject, _passSubject, (String phone, String pass) {
      return Validation.isPhoneValid(phone) && Validation.isPassValid(pass);
    }).listen((enable) {
      // cái stream vừa được combine sẽ được listen luôn, để phát event cho btnSink
      btnSink.add(enable);
    });
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event as SignInEvent);
        break;
    }
  }

  void handleSignIn(SignInEvent event) {
    _userRepo.signIn(event.phone, event.pass).then(
      (userData) => print(userData.displayName),
      onError: (e) {
        print(e);
      },
    );
  }

  @override
  void dispose() {
    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();

    super.dispose();
  }
}
