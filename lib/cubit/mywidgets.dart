import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String str;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;

  const MyText({
    Key? key,
    required this.str,
    this.color,
    this.size,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size ?? 18,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final Icon icon;

  final String labelText;

  final Color labelColor;
  final double size;
  final double radius;
  final double? side;

  const MyTextFormField({
    Key? key,
    required this.icon,
    required this.labelText,
    required this.labelColor,
    required this.size,
    required this.radius,
    this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          icon: icon,
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: size,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                width: side ?? 1,
              ))),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  Function onPressed;
  Widget widget;
  Color color;

  final double width, height;

  MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.widget,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        onPressed: () {
          onPressed();
        },
        child: widget,
      ),
    );
  }
}

class MyTextButton extends StatelessWidget {
  Function onPressed;
  Widget widget;

  MyTextButton({
    Key? key,
    required this.onPressed,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all(color),
          ),
      onPressed: () {
        onPressed();
      },
      child: widget,
    );
  }
}

push({required context, required Widget screen}) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => screen),
  );
}

pushReplacement({required context, required Widget screen}) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => screen),
  );
}
