import 'package:flutter/material.dart';

import '../constants.dart';

class ScaffoldDoNothingWidget extends StatefulWidget {
  final int configuracionLongPressStorage;
  final String configuracionColorStorage;
  final String configuracionImagenStorage;
  final int verImagenStorage;

  ScaffoldDoNothingWidget({
    this.configuracionLongPressStorage,
    this.configuracionColorStorage,
    this.configuracionImagenStorage,
    this.verImagenStorage,
  });
  @override
  _ScaffoldDoNothingWidgetState createState() =>
      _ScaffoldDoNothingWidgetState();
}

class _ScaffoldDoNothingWidgetState extends State<ScaffoldDoNothingWidget> {
  var _cantidadLongPress = 0;
  var _container;

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
  Widget build(BuildContext context) {
    if (widget.configuracionColorStorage == "Engrane") {
      _container = Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.configuracionImagenStorage),
            fit: BoxFit.cover,
          ),
        ),        
      );
    } 
    else if(widget.configuracionColorStorage == "Crashed") {
      _container = Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.configuracionImagenStorage),
            fit: BoxFit.cover,
          ),
        ),        
      );
    }
    else {
      _container = Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
      );
    }

    return GestureDetector(
      onLongPressEnd: (_) => _validarLongPress(),
      child: Scaffold(
        body: _container,
      ),
    );
  }
}
