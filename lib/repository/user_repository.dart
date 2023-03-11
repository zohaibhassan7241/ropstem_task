import 'package:ropstem_task/models/model_user.dart';
import 'package:ropstem_task/services/user_database.dart';

class UserRepository {
  static final UserDatabase userDb = UserDatabase();

  ///login
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {

    final response = await userDb.loginUser(username, password);
    if(response != null){
      return response;
    }else{
      return null;
    }
  }

  /// register account
  static Future<bool> register({
    required UserModel userModel,
  }) async {
    final response = await userDb.registerUser(userModel);
    if(response){
      return true;
    }else{
      return false;
    }

  }
  ///Logout User
  static Future<bool> logoutUser() async {
    final response = await userDb.logoutUser();
    if(response){
      return true;
    }else{
      return false;
    }

  }
}
