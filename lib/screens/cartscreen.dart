import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:tasksappsqflitenew/cubit/cubit.dart';
import 'package:tasksappsqflitenew/cubit/states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        var numCont = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: ConditionalBuilder(
            fallback: (BuildContext context) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Icon(
                      Icons.list,
                      size: 250,
                      color: Colors.deepPurple,
                    ),
                    const Text(
                      'There is no items  in cart  ',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is! GetHomeDataSuccessState)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      ),
                  ],
                ),
              );
            },
            builder: (BuildContext context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var product = cubit.cart[index];
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
                                if (product.discount != 0)
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
                                    height: 30,
                                  ),
                                  if (state is! ChangeCartLoadingState &&
                                      state is! GetHomeDataLoadingState)
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.redAccent)),
                                        onPressed: () {
                                          print(product.id);
                                          cubit.changeCart(product.id);
                                          if (cubit.changeCartModel!.status ==
                                              true) {
                                            Get.snackbar(
                                                'Done', 'You remove the item ',
                                                backgroundColor: Colors.green);
                                          }
                                          if (cubit.changeCartModel!.status ==
                                              false) {
                                            Get.snackbar(
                                                'Error',
                                                cubit.changeCartModel!.message
                                                    .toString(),
                                                backgroundColor: Colors.red);
                                          }
                                          cubit.getHomeData();
                                        },
                                        child: const Text('Remove from Cart '),
                                      ),
                                    ),
                                  if (state is ChangeCartLoadingState ||
                                      state is GetHomeDataLoadingState)
                                    const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  cubit.appear == false
                                                      ? Colors.deepPurple
                                                      : Colors.redAccent)),
                                      onPressed: () {
                                        cubit.changeAppear();
                                      },
                                      child: cubit.appear == true
                                          ? const Text('Cancel ')
                                          : const Text('Order it '),
                                    ),
                                  ),
                                  if (cubit.appear == true)
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          'enter 1 if you pay cash and 2 for online',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        TextFormField(
                                          key: GlobalKey<FormState>(),
                                          controller: numCont,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Invalid data';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            icon: const Icon(
                                              Icons.payment,
                                              color: Colors.deepPurple,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            labelText: 'enter payment method  ',
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Colors.deepPurple,
                                              ),
                                            ),
                                            onPressed: () {
                                              cubit.addOrder(
                                                num: int.parse(numCont.text),
                                              );
                                              Get.snackbar(
                                                  'Success',
                                                  cubit.addOrderModel!.message
                                                      .toString(),
                                                  backgroundColor:
                                                      Colors.green);
                                            },
                                            child: const Text('Confirm order '),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ]),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: cubit.cart.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      height: 2,
                      color: Colors.grey,
                    );
                  },
                ),
              );
            },
            condition: cubit.cart.isNotEmpty,
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     const Text(
//       'FAV',
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontStyle: FontStyle.italic,
//         fontSize: 22,
//         color: Colors.blueAccent,
//       ),
//     ),
//     const SizedBox(
//       width: 40,
//     ),
//     CircleAvatar(
//       child: IconButton(
//         onPressed: () {
//           cubit.changeFavorites(cubit
//               .favoritesModel!
//               .data!
//               .data[index]
//               .product
//               .id);
//           cubit.getFavorites();
//         },
//         icon: const Icon(
//           Icons.favorite_border,
//           color: Colors.white,
//         ),
//       ),
//       backgroundColor: Colors.blue,
//     ),
//   ],
// )
