import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tasksappsqflitenew/helpers/sharedpref.dart';

import 'login.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = ['First Login ', 'Second Browse products and offers ', 'Third Make order '];
    var images = ['assets/images/img.png',
      'assets/images/img_1.png',
      'assets/images/img_2.png',
    ] ;
    var pageCont = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text('OnBoarding'),
        backgroundColor: Colors.deepPurple,
      ),
      body: PageView.builder(
          controller: pageCont,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    Text(title[index].toString() ,style: const TextStyle(color: Colors.deepPurple , fontSize: 28 , fontWeight: FontWeight.w600),),
                    const SizedBox(height: 20,),
                    Image(image: AssetImage(images[index].toString(),) , height: 500,) ,
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        DotsIndicator(
                          dotsCount: title.length,
                          position: index.toDouble(),
                          decorator: const DotsDecorator(
                            color: Colors.deepOrange,
                            activeColor: Colors.deepPurple
                          ),
                        ) ,
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.deepPurple)
                          ),
                          onPressed: () {
                            if (index < title.length-1) {
                              pageCont.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                            } else {
                              CacheHelper.putBoolean(key: 'onBooarding', value: true).then((value) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                              });
                            }
                          },
                          child: const Icon(Icons.forward ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
