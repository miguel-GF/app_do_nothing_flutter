import 'dart:math';
import 'package:flutter/material.dart';

import '../models/mensaje.dart';

var mensajes = [
  {'id': 0, 'texto': 'Ponte a trabajar!!'},
  {'id': 1, 'texto': 'Alerta...!!'},
  {'id': 2, 'texto': 'Seriously?!'},
  {'id': 3, 'texto': '......'},
  {'id': 4, 'texto': 'Pronto algo pasará'},
  {'id': 5, 'texto': '¿Estás seguro de seguir con esto?'},
  {'id': 6, 'texto': 'Espero que sepas lo que haces...'},
  {'id': 7, 'texto': 'Give up pal'},
  {'id': 8, 'texto': 'O___o'},
  {'id': 9, 'texto': 'X___x'},
  {'id': 10, 'texto': 'x___X'},
  {'id': 11, 'texto': 'o___0'},
];

var imagenes = [
  {'id':0, 'urlImagen': 'assets/images/homer_crazy.gif'},
];

var lotties = [
  {'id':0, 'urlAsset': 'assets/json/dots_preloader.json'},
  {'id':1, 'urlAsset': 'assets/json/error_red.json'},
  {'id':2, 'urlAsset': 'assets/json/danger_red.json'},
];

var valoresLongPress = [
  {"key": UniqueKey(), "valor": 7, "texto": "Long Press *", "rango": 1},
  {"key": UniqueKey(), "valor": Random().nextInt(9) + 1, "texto": "Long Press *", "rango": 1},
  {"key": UniqueKey(), "valor": 16, "texto": "Long Press *", "rango": 2},
  {"key": UniqueKey(), "valor": Random().nextInt(29) + 11, "texto": "Long Press *", "rango": 2},
  {"key": UniqueKey(), "valor": 50, "texto": "Long Press *", "rango": 3},
  {"key": UniqueKey(), "valor": Random().nextInt(150) + 50, "texto": "Long Press *", "rango": 3},
].toList();

var valoresThemes = [
  {"key": UniqueKey(), "valor": 1, "color": "Blanco",    "imgSrc": "assets/images/engrane.jpg"},
  {"key": UniqueKey(), "valor": 1, "color": "Rojo",      "imgSrc": "assets/images/engrane.jpg"},
  {"key": UniqueKey(), "valor": 1, "color": "Azul",      "imgSrc": "assets/images/engrane.jpg"},
  {"key": UniqueKey(), "valor": 2, "color": "Engrane",   "imgSrc": "assets/images/engrane.jpg"},
  {"key": UniqueKey(), "valor": 2, "color": "Crashed",   "imgSrc": "assets/images/screen_crashed.png"},
].toList();

class Configuraciones {
  static Mensaje obtenerMensajeRandom() {
    var random = Random().nextInt(mensajes.length);
    var mensaje = mensajes.where((element) => element['id'] == random).toList();
    Mensaje respuesta = Mensaje(
      id: mensaje[0]['id'],
      texto: mensaje[0]['texto'],
    );
    return respuesta;
  }

  static String obtenerUrlImagenRandom() {
    var random = Random().nextInt(imagenes.length);
    var respuesta = imagenes.where((element) => element['id'] == random).toList();
    return respuesta[0]['urlImagen'];
  }

  static String obtenerUrlJsonRandom() {
    var random = Random().nextInt(lotties.length);
    var respuesta = lotties.where((element) => element['id'] == random).toList();
    return respuesta[0]['urlAsset'];
  }

  static String obtenerTipoAnimacion(int tipo) {
    switch(tipo) {
      case 0:
          return 'Mensaje';
          break;
      case 1:
          return 'Animacion';
          break;
      default:
          return 'Error';
    }
  }

  static List obtenerValoresLongPress() {
    return valoresLongPress;
  }

  static List obtenerValoresThemes() {
    return valoresThemes;
  }
}
