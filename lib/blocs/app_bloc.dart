import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final userCubit = UserCubit();
  static final loginCubit = LoginCubit();
  static final carCubit = CarsCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(
      create: (context) => applicationCubit,
    ),
    BlocProvider<UserCubit>(
      create: (context) => userCubit,
    ),
    BlocProvider<LoginCubit>(
      create: (context) => loginCubit,
    ),
    BlocProvider<CarsCubit>(
      create: (context) => carCubit,
    ),

  ];

  static void dispose() {
    userCubit.close();
    loginCubit.close();
    carCubit.close();
    applicationCubit.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
