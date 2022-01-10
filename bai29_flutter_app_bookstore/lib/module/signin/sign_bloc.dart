import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/user_repo.dart';
import 'package:bai29_flutter_app_bookstore/data/spref/spref.dart';
import 'package:bai29_flutter_app_bookstore/event/signin_event.dart';
import 'package:bai29_flutter_app_bookstore/event/signup_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/user_data.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/constant.dart';

class SignInBloc extends BaseBloc {
  final UserRepo _userRepo;

  SignInBloc({required UserRepo userRepo}) : _userRepo = userRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event as SignInEvent);
        break;
      case SignUpEvent:
        handleSignUp(event as SignUpEvent);
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

  void handleSignUp(SignUpEvent event) {}
}
