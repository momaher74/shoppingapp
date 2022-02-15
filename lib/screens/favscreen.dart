import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConditionalBuilder(
            fallback: (BuildContext context) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ));
            },
            builder: (BuildContext context) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var product = cubit.favoritesModel!.data!.data[index].product;
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              Image(
                                image: NetworkImage(product.image),
                                width: 200,
                                height: 200,
                              ),
                              if (cubit.favoritesModel!.data!.data[index]
                                  .product.discount !=
                                  0)
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: const Text(
                                    'discount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            width: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Center(
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  width: 400,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Wrap(
                                  children: [
                                    const Text(
                                      'Price :    ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      product.price.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (product.discount != 0)
                                  Text(
                                    'old Price :' +
                                        product.oldPrice.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'FAV',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 22,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    CircleAvatar(
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.changeFavorites(cubit.favoritesModel!.data!.data[index].product.id);
                                          cubit.getFavorites();
                                        },
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                  );
                },
                shrinkWrap: true,
                itemCount: cubit.favoritesModel!.data!.data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    height: 2,
                    color: Colors.grey,
                  );
                },
              );
            },
            condition: state is! GetFavoritesLoadingState,
          ),
        ));
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
