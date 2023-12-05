import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText(
      {super.key,
        this.color = const Color((0xff332d2d)),
        required this.text,
        this.overflow = TextOverflow.ellipsis,
        this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(color: color, fontWeight: FontWeight.w400,fontSize: size),
    );
  }
}
