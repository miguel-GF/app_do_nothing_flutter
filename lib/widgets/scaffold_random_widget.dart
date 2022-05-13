import 'dart:math';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/mensaje.dart';
import '../models/configuracion_usuario.dart';
import '../services/configuraciones.dart';
import './normal_container_widget.dart';
import './lottie_container_widget.dart';
import './text_figure_animated_widget.dart';

class ScaffoldRandomWidget extends StatefulWidget {
  final idStorage;
  final configuracionClicksStorage;
  final crazyCellStorage;
  final configuracionLongPressStorage;
  final String configuracionColorStorage;
  final String configuracionImagenStorage;
  final int verImagenStorage;

  ScaffoldRandomWidget({
    @required this.idStorage,
    @required this.configuracionClicksStorage,
    @required this.crazyCellStorage,
    @required this.configuracionLongPressStorage,
    this.configuracionColorStorage,
    this.configuracionImagenStorage,
    this.verImagenStorage,
  });
  @override
  _ScaffoldRandomWidgetState createState() => _ScaffoldRandomWidgetState();
}

class _ScaffoldRandomWidgetState extends State<ScaffoldRandomWidget> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  Mensaje _mensajeAleatorio;
  ConfiguracionUsuario _configuracionUsuario;
  int _countTaps = 0;
  bool _showImage = false;
  String _lottieUrl;
  int _randomScreen;
  int _tapsScreenFin;
  int _tapsScreen = 0;
  var _cantidadLongPress = 0;
  int _doubleTapFin;
  int _doubleTapCantidad = 0;

  Future<void> _validarLongPress() async {
    setState(() {
      _cantidadLongPress++;
    });
    if (_cantidadLongPress == widget.configuracionLongPressStorage) {
      setState(() {
        _cantidadLongPress = 0;
        Navigator.pushNamed(context, configuracionScreenRoute);
      });
    }
  }

  @override
  void initState() {
    setState(() {
      _doubleTapFin = 1 + Random().nextInt(20);
      _tapsScreenFin = 1 + Random().nextInt(20);
      _mensajeAleatorio = Configuraciones.obtenerMensajeRandom();
      //var animacion = Configuraciones.obtenerTipoAnimacion(Random().nextInt(2));
      _configuracionUsuario = ConfiguracionUsuario(
        configuracionClicks: widget.configuracionClicksStorage,
        crazyCell: widget.crazyCellStorage,
      );
      if (widget.crazyCellStorage) {
        var rand = Random().nextInt(3);
        if (rand == 2) {
          _lottieUrl = Configuraciones.obtenerUrlJsonRandom();
        } else {
          _lottieUrl = null;
        }
        _randomScreen = rand;
      } else
        _randomScreen = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> validarTaps() async {
      if (widget.crazyCellStorage) {
        if (_tapsScreen <= _tapsScreenFin) {
          if (_configuracionUsuario.configuracionClicks == _countTaps) {
            setState(() {
              _countTaps = 0;
              _mensajeAleatorio = Configuraciones.obtenerMensajeRandom();
              _showImage = !_showImage;
            });
            //Navigator.pushNamed(context, configuracionScreenRoute);
          }
        } else {
          int rand = Random().nextInt(3);
          String lottieUrl;
          if (rand == 2) {
            lottieUrl = Configuraciones.obtenerUrlJsonRandom();
          } else {
            lottieUrl = null;
          }
          setState(() {
            _lottieUrl = lottieUrl;
            _randomScreen = rand;
            _countTaps = 0;
            _tapsScreen = 0;
            _tapsScreenFin = 1 + Random().nextInt(20);
          });
        }
      }
    }

    Future<void> animar() async {
      setState(() {
        // Create a random number generator.
        final random = Random();
        _countTaps++;
        _tapsScreen++;
        // Generate a random width and height.
        _width = random.nextInt(300).toDouble();
        _height = random.nextInt(300).toDouble();

        // Generate a random color.
        _color = Color.fromRGBO(
            random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);

        // Generate a random border radius.
        _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
      });
    }

    Future<void> validarDoubleTap() async {
      _doubleTapCantidad++;
      if (_doubleTapCantidad == _doubleTapFin) {
        _mensajeAleatorio = Configuraciones.obtenerMensajeRandom();
        _doubleTapCantidad = 0;
        _doubleTapFin = 1 + Random().nextInt(20);
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            _mensajeAleatorio.texto,
            textAlign: TextAlign.center,
          ),
        ));
      }
      setState(() {});
    }

    Size mediaQ = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => animar().then((_) => validarTaps()),
      onDoubleTap: () {
        validarDoubleTap();
      },
      onLongPressEnd: (_) => _validarLongPress(),
      child: Scaffold(
        body: _randomScreen == 0
            ? TextFigureAnimatedWidget(
                mediaQ: mediaQ,
                mensajeAleatorio: _mensajeAleatorio,
                showImage: _showImage,
                width: _width,
                height: _height,
                borderRadius: _borderRadius,
                color: _color,
                configuracionImagenStorage: widget.configuracionImagenStorage,
                verImagenStorage: widget.verImagenStorage,
              )
            : _randomScreen == 1
                ? NormalContainerWidget(
                    configuracionImagenStorage: widget.configuracionImagenStorage,
                    verImagenStorage: widget.verImagenStorage,
                  )
                : LottieContainerWidget(
                    lottieUrl: _lottieUrl,
                    configuracionImagenStorage:
                        widget.configuracionImagenStorage,
                  ),
      ),
    );
  }
}
