import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';
import 'package:tasksappsqflitenew/helpers/sharedpref.dart';
import 'package:tasksappsqflitenew/screens/homescreen.dart';
import 'package:tasksappsqflitenew/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isTrue = true;
IconData passIcon = Icons.visibility;

icon() {
  if (isTrue == true) {
    passIcon = Icons.visibility;
  } else {
    passIcon = Icons.visibility_off;
  }
}

var formKey = GlobalKey<FormState>();
TextEditingController emailCont = TextEditingController();
TextEditingController passCont = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
         // print('Okaaaaaaaaaaaay');
          if(AppCubit.get(context).userModel!.status == true){
            CacheHelper.saveData(key: 'token', value: AppCubit.get(context).userModel!.data.token).then((value) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            });
          }
          else{
            //print('loginnnnnnnnnn is ffffffffffffffalse status ') ;
          }

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Login',
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Login here to browse our products ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      controller: emailCont,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.alternate_email,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'enter your email ',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      controller: passCont,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isTrue = !isTrue;
                              icon();
                            });
                          },
                          child: Icon(
                            passIcon,
                            color: Colors.deepPurple,
                          ),
                        ),
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'enter your password ',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isTrue,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is! LoginLoadingState)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 800,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepPurple)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).login(
                                email: emailCont.text,
                                password: passCont.text,
                              );
                            }
                          },
                          child: const Icon(Icons.login),
                        ),
                      ),
                    if (state is LoginLoadingState)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Don\'t have account ? ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
