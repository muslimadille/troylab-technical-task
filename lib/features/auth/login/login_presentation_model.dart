import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  ):loginResult = const FutureResult.empty(),
        loginButtonState=false;

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.loginResult,
    required this.loginButtonState,
});
  final FutureResult<Either<LogInFailure, User>> loginResult;
  final bool loginButtonState;

  @override
  bool get isLoading => loginResult.isPending();
  @override
  bool get isLoginEnabled => loginButtonState;

  LoginPresentationModel copyWith({
    FutureResult<Either<LogInFailure, User>>? loginResult,
    bool? loginButtonStatus,

  }) {
    return LoginPresentationModel._(
      loginResult: loginResult??this.loginResult,
      loginButtonState: loginButtonStatus??loginButtonState,
    );
  }
  bool loginButtonStatus({required bool status}){
    return status;
  }



}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoading;
  bool get isLoginEnabled;


}
