import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';
import 'package:tasksappsqflitenew/methods.dart';
import 'package:tasksappsqflitenew/screens/cartscreen.dart';
import 'package:tasksappsqflitenew/screens/settings.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  push(context, const SettingsScreen());
                },
                icon: const Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  push(context, const CartScreen());
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.deepPurple,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeNavScreen(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.app_registration),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourite',
              ),
            ],
          ),
        );
      },
    );
  }
}
