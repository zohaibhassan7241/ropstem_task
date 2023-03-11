import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ropstem_task/blocs/application/application_state.dart';
import 'package:ropstem_task/services/car_database.dart';
import 'package:ropstem_task/services/user_database.dart';


class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.loading);

  ///On Setup Application
  void onSetup() async {
    final carDatabase = CarDatabase();
    final userDatabase = UserDatabase();
    ///Inset Car Data
   await carDatabase.getCars().then((value) async {
     if(value.isEmpty){
       await carDatabase.insertCars(dummyCars);
     }
   });
   ///Check IS User Login
   final value = await userDatabase.checkISLoggedIn();
   if(value){
     emit(ApplicationState.loggedIN);
   }else{
     emit(ApplicationState.completed);
   }
  }
}
