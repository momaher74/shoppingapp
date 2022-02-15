import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';
import 'package:tasksappsqflitenew/methods.dart';
import 'package:tasksappsqflitenew/screens/proddescscreen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    List prodDescription = [];
    List prodImg = [];
    List prodId = [];

    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (cubit.productsModel!.data != null)
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.productsModel!.data!.products.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: .5,
                        ),
                        itemBuilder: (context, index) {
                          var product =
                              cubit.productsModel!.data!.products[index];
                          prodDescription.add(cubit.productsModel!.data!
                              .products[index].description);
                          prodImg.add(
                              cubit.productsModel!.data!.products[index].image);
                          prodId.add(
                              cubit.productsModel!.data!.products[index].id);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  push(
                                    context,
                                    ProductDescription(
                                      text: prodDescription[index],
                                      url: prodImg[index],
                                      id: prodId[index],
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.topStart,
                                  children: [
                                    Image(
                                      image: NetworkImage(prodImg[index]),
                                      width: 200,
                                      height: 200,
                                    ),
                                    if (product.discount != 0)
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(.7),
                                          borderRadius:
                                              BorderRadius.circular(22),
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
                              ),
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              if (product.discount != 0)
                                Text(
                                  'old Price :' + product.oldPrice.toString(),
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
                                        print(cubit
                                            .productsModel!
                                            .data!
                                            .products[index]
                                            .id) ;
                                        print(cubit.favorites[cubit
                                            .productsModel!
                                            .data!
                                            .products[index]
                                            .id]) ;
                                        cubit.changeFavorites(cubit
                                            .productsModel!
                                            .data!
                                            .products[index]
                                            .id);

                                      },
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: cubit.favorites[cubit
                                                .productsModel!
                                                .data!
                                                .products[index]
                                                .id] ==
                                            true
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  if (cubit.productsModel!.data == null)
                    const Center(
                        child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    )),
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
