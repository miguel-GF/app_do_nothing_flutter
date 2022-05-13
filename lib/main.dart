// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './router.dart';
import './screens/home_screen.dart';
import './screens/configuracion_screen.dart';
import './constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _id;
  var _configuracionClicks;
  var _configuracionLongPress;
  var _crazyCell;
  var _configuracionColor;
  var _configuracionImagen;
  var _verImagen;
  var _color;
  var _colorSecundario;

  @override
  void initState() {
    getData();
    //removeData();
    // setData(
    //   id: UniqueKey().toString(),
    //   configuracionClicks: 10,
    //   crazyCell: true,
    // );
    super.initState();
  }
  
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = prefs.getString('id');
      _configuracionClicks = prefs.getInt('configuracionClicks');
      _crazyCell = prefs.getBool('crazyCell');
      _configuracionLongPress = prefs.getInt('configuracionLongPress');
      _configuracionColor = prefs.getString('configuracionColor');
      _configuracionImagen = prefs.getString('configuracionImagen');
      _verImagen = prefs.getInt('verImagen');
    });

    if (_configuracionColor == "Blanco") {
      _color = blancoPrimario;
      _colorSecundario = blancoSecundario;
    } else if (_configuracionColor == "Rojo") {
      _color = rojoPrimario;
      _colorSecundario = rojoSecundario;
    } else if (_configuracionColor == "Azul") {
      _color = azulPrimario;
      _colorSecundario = azulSecundario;
    } else {
      _color = rojoPrimario;
      _colorSecundario = rojoSecundario;
    }
  }

  removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('configuracionClicks');
    prefs.remove('crazyCell');
    prefs.remove('configuracionLongPress');
  }

  setData({String id, int configuracionClicks, bool crazyCell}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setInt('configuracionClicks', configuracionClicks);
    prefs.setBool('crazyCell', crazyCell);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'App Nothing',
      theme: ThemeData(
        primaryColor: _color,
        buttonColor: _colorSecundario,
        textTheme: TextTheme(
          headline1: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,), 
          headline2: const TextStyle( fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 1.5), 
          headline3: const TextStyle( fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black, letterSpacing: 1.2), 
        ),
      ),      
      home: _id != null ? HomeScreen(
        idStorage: _id,
        configuracionClicksStorage: _configuracionClicks,
        configuracionLongPressStorage: _configuracionLongPress,
        crazyCellStorage: _crazyCell,
        configuracionColorStorage: _configuracionColor,
        configuracionImagenStorage: _configuracionImagen,
        verImagenStorage: _verImagen,
      ) : ConfiguracionScreen(),
      onGenerateRoute: Rutas.generateRoute,
    );
  }
}
