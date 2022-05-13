import 'package:flutter/material.dart';

import '../widgets/scaffold_random_widget.dart';
import '../widgets/scaffold_do_nothing_widget.dart';

class HomeScreen extends StatefulWidget {
  final idStorage;
  final configuracionClicksStorage;
  final crazyCellStorage;
  final configuracionLongPressStorage;
  final configuracionColorStorage;
  final configuracionImagenStorage;
  final verImagenStorage;

  HomeScreen({
    @required this.idStorage,
    @required this.configuracionClicksStorage,
    @required this.crazyCellStorage,
    @required this.configuracionLongPressStorage,
    @required this.configuracionColorStorage,
    @required this.configuracionImagenStorage,
    @required this.verImagenStorage,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffoldRandomWidget = ScaffoldRandomWidget(
      idStorage: widget.idStorage,
      configuracionClicksStorage: widget.configuracionClicksStorage,
      crazyCellStorage: widget.crazyCellStorage,
      configuracionLongPressStorage: widget.configuracionLongPressStorage,
      configuracionColorStorage: widget.configuracionColorStorage,
      configuracionImagenStorage: widget.configuracionImagenStorage,
      verImagenStorage: widget.verImagenStorage,
    );
    var scaffoldDoNothingWidget = ScaffoldDoNothingWidget(
      configuracionLongPressStorage: widget.configuracionLongPressStorage,
      configuracionColorStorage: widget.configuracionColorStorage,
      configuracionImagenStorage: widget.configuracionImagenStorage,
      verImagenStorage: widget.verImagenStorage,
    );
    if (widget.crazyCellStorage)
      return scaffoldRandomWidget;
    else
      return scaffoldDoNothingWidget;
  }
}
