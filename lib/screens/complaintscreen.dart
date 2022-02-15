import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
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
TextEditingController messageCont = TextEditingController();
TextEditingController nameCont = TextEditingController();
TextEditingController phoneCont = TextEditingController();

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Complaint',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'what is your complaint or comment ? ',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 23,
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
                      controller: messageCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.messenger_outline_outlined,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'enter your complaint or comment here  ',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is! ComplaintLoadingState)
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
                              AppCubit.get(context).complaint(
                                name: nameCont.text,
                                phone: int.parse(phoneCont.text),
                                email: emailCont.text,
                                message: messageCont.text,
                              );
                              if (state is ComplaintSuccessState) {
                                Get.snackbar(
                                  'successed',
                                  AppCubit.get(context)
                                      .complaintModel!
                                      .message! ,
                                  backgroundColor: Colors.green ,
                                  borderRadius: 22
                                );
                              }
                            }
                          },
                          child: const Icon(Icons.upload_rounded),
                        ),
                      ),
                    if (state is ComplaintLoadingState)
                      const Center(
                          child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      )),
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
