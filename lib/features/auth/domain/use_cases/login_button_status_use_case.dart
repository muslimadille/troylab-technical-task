class LoginButtonStatusUseCase{
  bool isLoginButtonEnable({required String userName,required String password}){
    if(userName.isNotEmpty&&password.isNotEmpty){
      return true;
    }
    return false;
  }
}
