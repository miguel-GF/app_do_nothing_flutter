import 'dart:math';
import 'package:flutter/material.dart';

import '../models/mensaje.dart';
import './animated_text_widget.dart';
import './animated_container_widget.dart';

class TextFigureAnimatedWidget extends StatelessWidget {
  const TextFigureAnimatedWidget({
    Key key,
    @required this.mediaQ,
    @required Mensaje mensajeAleatorio,
    @required bool showImage,
    @required double width,
    @required double height,
    @required BorderRadiusGeometry borderRadius,
    @required Color color,
    @required this.configuracionImagenStorage,
    @required this.verImagenStorage,
  })  : _mensajeAleatorio = mensajeAleatorio,
        _showImage = showImage,
        _width = width,
        _height = height,
        _borderRadius = borderRadius,
        _color = color,
        super(key: key);

  final Size mediaQ;
  final Mensaje _mensajeAleatorio;
  final bool _showImage;
  final double _width;
  final double _height;
  final BorderRadiusGeometry _borderRadius;
  final Color _color;
  final configuracionImagenStorage;
  final verImagenStorage;

  @override
  Widget build(BuildContext context) {
    //if (!_showImage)
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: verImagenStorage == 1
            ? null
            : DecorationImage(
                image: AssetImage(configuracionImagenStorage),
                fit: BoxFit.cover,
              ),
      ),
      height: mediaQ.height * 1,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedContainerWidget(
            width: _width,
            height: _height,
            borderRadius: _borderRadius,
            color: _color,
          ),
        ],
      ),
    );

    // return Column(
    //   //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: <Widget>[
    //     // Container(
    //     //   decoration: BoxDecoration(
    //     //     color: Theme.of(context).primaryColor,
    //     //   ),
    //     //   alignment: Alignment.center,
    //     //   height: mediaQ.height * 0.25,
    //     //   width: double.infinity,
    //     //   child: AnimatedTextWidget(
    //     //     texto: _mensajeAleatorio.texto,
    //     //     fontSize: Random().nextInt(20) + 14,
    //     //     color: Color.fromRGBO(
    //     //       Random().nextInt(256),
    //     //       Random().nextInt(256),
    //     //       Random().nextInt(256),
    //     //       1,
    //     //     ),
    //     //   ),
    //     // ),
    //     Container(
    //       decoration: BoxDecoration(
    //         color: Theme.of(context).primaryColor,
    //       ),
    //       height: mediaQ.height * 0.75,
    //       width: double.infinity,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           AnimatedContainerWidget(
    //             width: _width,
    //             height: _height,
    //             borderRadius: _borderRadius,
    //             color: _color,
    //             verImagen: true,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
