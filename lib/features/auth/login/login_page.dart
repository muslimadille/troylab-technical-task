// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter>{
  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  TextEditingController userNameTextController=TextEditingController();
  TextEditingController passwordTextController=TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userNameTextController,
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => presenter.checkLoginButtonState(
                  userName: userNameTextController.text,
                  password: passwordTextController.text,),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => presenter.checkLoginButtonState(
                  userName: userNameTextController.text,
                  password: passwordTextController.text,),
              ),
              const SizedBox(height: 16),
              stateObserver(
                builder: (context, state) => state.isLoading?const CircularProgressIndicator():ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: state.isLoginEnabled?Colors.blueAccent:Colors.grey, // background color
                    ),
                  onPressed: ()=>onLoginClicked(state: state.isLoginEnabled),
                  child: Text(appLocalizations.logInAction),
                ),
              ),
            ],
          ),
        ),
      );
  void onLoginClicked({required bool state}){
    if(state){
    presenter.setTextState(
      username: userNameTextController.text,
      password: passwordTextController.text,
    );}
  }
}
