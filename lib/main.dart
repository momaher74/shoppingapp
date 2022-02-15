import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';
import 'package:tasksappsqflitenew/helpers/diohelper.dart';
import 'package:tasksappsqflitenew/helpers/sharedpref.dart';
import 'package:tasksappsqflitenew/screens/login.dart';
import 'package:tasksappsqflitenew/screens/mypageviewscreen.dart';
import 'package:tasksappsqflitenew/screens/navscreen.dart';

import 'cubit/observar.dart';

bool? onBoarding;

String token = '';
bool? mode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  //await Firebase.initializeApp();
  onBoarding = CacheHelper.getData(key: 'onBooarding');
  token = CacheHelper.getData(key: 'token');
  mode = CacheHelper.getData(key: 'dark');
  print('token = ' + token);
  Widget? widget;
  if (token != null) {
    widget = const NavScreen();
  } else {
    if (onBoarding == true) {
      widget = const LoginScreen();
    } else {
      widget = const OnBoardingScreen();
    }
  }
  BlocOverrides.runZoned(
    () => runApp(MyApp(
      widget: widget!,
      mode: mode,
    )),
    blocObserver: AppBlocObserver(),
  );
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Widget? widget;
  bool? mode;

  MyApp({Key? key, required this.widget, required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit()
        ..getBanners()
        ..getCategory()
        ..getContacts()
        ..repeatedQuestionsFun()
        ..getHomeData()
        ..getNotification()
        ..getFavorites()
        ..getCart()
        ..getOrders()
        ..getAddress()
        ..viewProfile(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Colors.deepPurple),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
            ),
            themeMode: mode == true ? ThemeMode.dark : ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
