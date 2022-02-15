import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';

class NotScreen extends StatelessWidget {
  const NotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notification'),
          ),
          body:ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Column(
                      children: [
                        Text(
                          cubit.notificationModel!.data!.data[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Text(
                          cubit.notificationModel!.data!.data[index].message,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              color: Colors.white),
                        ) ,
                      ],
                    ),
                  ),


                ],
              );
            },
            itemCount: cubit.notificationModel!.data!.data.length,
            shrinkWrap: true,
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
