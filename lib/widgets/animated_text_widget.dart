import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  final texto;
  final fontSize;
  final color;

  AnimatedTextWidget({
    @required this.texto,
    @required this.fontSize,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      child: Text(texto),
      style: TextStyle(
        color: color,
        fontSize: fontSize.toDouble(),
      ),
      duration: Duration(milliseconds: 500),
    );
  }
}
