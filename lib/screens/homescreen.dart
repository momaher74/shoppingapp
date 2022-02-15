import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 33,
                  ),
                  if (AppCubit.get(context).bannersModel != null)
                    CarouselSlider(
                      items: AppCubit.get(context)
                          .bannersModel!
                          .data
                          .map((e) => Card(
                                elevation: 12,
                                shadowColor: Colors.deepPurple,
                                child: Image(
                                  image: NetworkImage(e.image ),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 400),
                          pauseAutoPlayOnManualNavigate: true),
                    ),
                  if (AppCubit.get(context).bannersModel == null)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Text(
                      'Category',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (cubit.categoryModel != null)
                    categoryBuilder(context: context),
                  if (cubit.contactsModel != null)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Text(
                            'Contact us here :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(22)),
                          width: double.infinity,
                          height: 60,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Uri(path: cubit.contactsModel!.data!.data[0].value);
                                  launch(cubit
                                      .contactsModel!.data!.data[index].value);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image(
                                    image: NetworkImage(
                                      cubit.contactsModel!.data!.data[index]
                                          .image,
                                    ),
                                    width: 50,
                                  ),
                                ),
                              );
                            },
                            itemCount: cubit.contactsModel!.data!.data.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.all(12),
                                width: 2,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

categoryBuilder({required context}) => SizedBox(
      width: double.infinity,
      height: 220,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image(
                image: NetworkImage(
                  AppCubit.get(context).categoryModel!.data!.data![index].image,
                ),
                width: 150,
                height: 120,
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                child: Text(
                  AppCubit.get(context).categoryModel!.data!.data![index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(1),
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            ],
          );
        },
        itemCount: AppCubit.get(context).categoryModel!.data!.data!.length,
        shrinkWrap: true,
      ),
    );
