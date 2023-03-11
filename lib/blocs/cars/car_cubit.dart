
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ropstem_task/services/car_database.dart';

class CarsCubit extends Cubit<List<Car>> {
  CarsCubit() : super([]);
  final carDatabase = CarDatabase();
  Future<void> addCar(Car car) async {
    await carDatabase.addCar(car);
    emit([...state, car]);
  }
///Update Cars
  Future<void> updateCar(int index, Car car) async {
    final cars = List.of(state);
    cars[index] = car;
    await carDatabase.updateCar(car);
    emit(cars);
  }
  ///Delete Cars

  Future<void> removeCar(int index) async {
    final cars = List.of(state);
    await carDatabase.removeCar(cars[index]);
    cars.removeAt(index);
    emit(cars);
  }
///Get Cars
  Future<void> loadCars() async {
    final cars = await carDatabase.getCars();
    log(cars.length.toString());
    emit(cars);
  }

}