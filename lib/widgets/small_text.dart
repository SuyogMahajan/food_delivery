import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/colors.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  SmallText(
      {Key? key,
        this.color = const Color(0xFFccc7c5),
        required this.text,
        this.size = 12
  ,this.height = 1.2    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Roboto',height: height),
    );
  }
}