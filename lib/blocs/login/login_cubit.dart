import 'package:bloc/bloc.dart';
import 'package:ropstem_task/repository/user_repository.dart';

enum LoginState {
  init,
  loading,
  success,
  fail,
  logout
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.init);
  void onLogin({
    required String username,
    required String password,
  }) async {
    ///Notify
    emit(LoginState.loading);
    ///login via repository
    final result = await UserRepository.login(
      username: username,
      password: password,
    );

    if (result != null) {

      ///Notify
      emit(LoginState.success);
    } else {
      ///Notify
      emit(LoginState.fail);
    }
  }

  void onLogout() async {
    ///Logout
    final result = await UserRepository.logoutUser();
    if(result){
      emit(LoginState.logout);
    }else{
      emit(LoginState.init);
    }
  }
}
