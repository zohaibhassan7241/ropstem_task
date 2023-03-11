

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ropstem_task/models/model.dart';
import 'package:ropstem_task/repository/user_repository.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);
  ///Event register
  Future<bool> onRegister({
   required UserModel userModel,
  }) async {
    return await UserRepository.register(
      userModel: userModel
    );
  }
}
