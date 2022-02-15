import 'package:flutter/material.dart';

push(context, screen) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

pushReplacement(context, screen) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

class MyHeightSizedBox extends StatelessWidget {
  double? x;

  MyHeightSizedBox({required this.x});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: x,
    );
  }
}

class MyWidthSizedBox extends StatelessWidget {
  double? x;

  MyWidthSizedBox({required this.x});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: x,
    );
  }
}

class MyElevetedButton extends StatelessWidget {
  double? height;
  double? width;
  Color color;
 Function function ;
  Widget widget;

  MyElevetedButton({
    required this.height,
    required this.width,
    required this.color,
    required this.widget,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color),),
        onPressed: () {
          function();
        },
        child: widget,
      ),
    );
  }
}
