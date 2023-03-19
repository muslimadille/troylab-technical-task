import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/login_button_status_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
      this.loginUseCase,
      this.loginButtonStatusUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase loginUseCase;
  final LoginButtonStatusUseCase loginButtonStatusUseCase;





  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  Future<void> setTextState({
    required String username,
    required String password,}) async {
     await await loginUseCase.execute(username: username,password: password).observeStatusChanges((loginResult) => emit(_model.copyWith(loginResult: loginResult)))
         .asyncFold(
           (fail) => navigator.showError(fail.displayableFailure()),
           (success) => navigator.showAlert(title: "Login Success", message: "Welcome"),
     );
  }
  void checkLoginButtonState({required String userName,required String password}){
    emit(_model.copyWith(loginButtonStatus: loginButtonStatusUseCase.isLoginButtonEnable(userName: userName, password: password)));
  }


}
