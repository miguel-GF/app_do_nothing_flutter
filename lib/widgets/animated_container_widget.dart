import 'package:flutter/material.dart';

import '../services/configuraciones.dart';
import './normal_container_widget.dart';

class AnimatedContainerWidget extends StatelessWidget {
  final width;
  final height;
  final color;
  final borderRadius;
  final verImagen;

  AnimatedContainerWidget({
    @required this.width,
    @required this.height,
    @required this.color,
    @required this.borderRadius,
    this.verImagen,
  });

  @override
  Widget build(BuildContext context) {
    return verImagen != true
        ? AnimatedContainer(
            // Use the properties stored in the State class.
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            ),
            // Define how long the animation should take.
            duration: Duration(seconds: 1),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
          )
        : NormalContainerWidget(
            imagen: Configuraciones.obtenerUrlImagenRandom(),
          );
  }
}
