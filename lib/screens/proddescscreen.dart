import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';

class ProductDescription extends StatelessWidget {
  String? url;

  String? text;
  int? id;

  ProductDescription(
      {Key? key, required this.text, required this.url, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Description'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Column(
                    children: [
                      Image(
                        image: NetworkImage(url!),
                        width: 300,
                        height: 400,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        text!,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is! ChangeCartLoadingState && state is! GetHomeDataLoadingState)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepPurple)),
                        onPressed: () {
                          print(id);
                          cubit.changeCart(id);
                          if (cubit.changeCartModel!.status==true) {
                            Get.snackbar('Done',
                               'Done successfully',
                                backgroundColor: Colors.green);
                          }
                          if (cubit.changeCartModel!.status==false) {
                            Get.snackbar('Error',
                                cubit.changeCartModel!.message.toString(),
                                backgroundColor: Colors.red);
                          }
                          cubit.getHomeData();
                        },
                        child: const Text('Add to Card '),
                      ),
                    ),
                  if (state is ChangeCartLoadingState || state is GetHomeDataLoadingState )
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
