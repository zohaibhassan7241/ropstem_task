import 'package:flutter/material.dart';
import 'package:ropstem_task/screens/dashboard/add_car.dart';
import 'package:ropstem_task/screens/screen.dart';

class RouteArguments<T> {
  final T? item;
  final VoidCallback? callback;
  RouteArguments({this.item, this.callback});
}

class Routes {
  static const String logIn = "/logIn";
  static const String signUp = "/signUp";
  static const String dashboard = "/dashboard";
  static const String carCUPage = "/create&update";



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case logIn:
        return MaterialPageRoute(
          builder: (context) {
            return const Login();
          },
          fullscreenDialog: true,
        );

      case signUp:
        return MaterialPageRoute(
          builder: (context) {
            return const SignUp();
          },
        );
      case dashboard:
        return MaterialPageRoute(
          builder: (context) {
            return  const Dashboard();
          },
          fullscreenDialog: true,
        );
        case carCUPage:
          List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (context) {
            return   CarAddUpdate(car: args![0],);
          },
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
