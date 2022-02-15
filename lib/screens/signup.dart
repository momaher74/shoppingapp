import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';
import 'package:tasksappsqflitenew/helpers/sharedpref.dart';

import 'homescreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
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
TextEditingController nameCont = TextEditingController();
TextEditingController phoneCont = TextEditingController();

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(AppCubit.get(context).userModel!.status==true){
          CacheHelper.saveData(key: 'token', value:AppCubit.get(context).userModel!.data.token ).then((value) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Signup',
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
                      'Signup here to browse our products ',
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
                      controller: nameCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.alternate_email,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'enter your name ',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'enter your number ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.email,
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
                      controller: passCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
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
                    if(state is ! RegisterLoadingState)
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
                            AppCubit.get(context).signup(
                              name: nameCont.text,
                              phone: phoneCont.text,
                              email: emailCont.text,
                              password: passCont.text,
                            );
                          }
                        },
                        child: const Icon(Icons.login),
                      ),
                    ),
                    if(state is RegisterLoadingState)
                      const Center(child: CircularProgressIndicator(color: Colors.deepPurple,)) ,
                    const SizedBox(
                      height: 40,
                    ),
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
