import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ropstem_task/configs/theme.dart';
import 'package:ropstem_task/screens/dashboard/dashboard.dart';
import 'package:ropstem_task/screens/loading/loading.dart';
import 'package:ropstem_task/screens/login/login.dart';

import 'blocs/bloc.dart';
import 'configs/config.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(brightness: Brightness.light),
        onGenerateRoute: Routes.generateRoute,
        home: Scaffold(
          body: BlocBuilder<ApplicationCubit, ApplicationState>(
              builder: (context, application) {
                if (application == ApplicationState.loggedIN) {
                  return const Dashboard();
                }else if(application == ApplicationState.completed){
                  return const Login();
                }else{
                  return const SplashScreen();
                }
              },
            ),
        ),
        builder: (context, child) {
          final data = MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          );
          return MediaQuery(
            data: data,
            child: child!,
          );
        },
      ),
    );
  }
}
