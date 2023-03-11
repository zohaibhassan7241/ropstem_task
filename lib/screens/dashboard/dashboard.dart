import 'package:flutter/material.dart';
import 'package:ropstem_task/blocs/bloc.dart';
import 'package:ropstem_task/configs/config.dart';
import 'package:ropstem_task/configs/image.dart';
import 'package:ropstem_task/services/car_database.dart';
import 'package:ropstem_task/widgets/app_list_title.dart';
import 'package:ropstem_task/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CarsCubit>().loadCars();
    return Scaffold(
      appBar: AppBar(title: const Text('DashBoard'), actions: [
        IconButton(onPressed: () {
          ///Logout
          context.read<LoginCubit>().onLogout();
        }, icon: const Icon(Icons.logout_sharp)),
      ],),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if(state == LoginState.logout){
            ///Logout
            Future.delayed(Duration.zero, () async {
              Navigator.pushNamedAndRemoveUntil(context, Routes.logIn, (route) => false);
            });
          }
          return BlocBuilder<CarsCubit, List<Car>>(
            builder: (context, state) {
              if (state.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                ///Cars List
                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    final car = state[index];
                    return AppListTitle(title: car.model,
                      subtitle: car.make,
                      trailing: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.carCUPage, arguments: [state[index]]).then((
                                  value) {
                                if (value != null) {
                                  context.read<CarsCubit>().updateCar(index, value as Car);
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              BlocProvider.of<CarsCubit>(context).removeCar(index);
                            },
                          ),
                        ],
                      ),


                    );
                  },
                );
              }
            },
          );
        },
      ),
      ///Floating Action Button
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, Routes.carCUPage, arguments: [null]).then((value) {
          if (value != null) {
            context.read<CarsCubit>().addCar(value as Car);
          }
        });
      },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

