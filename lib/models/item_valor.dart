import 'package:flutter/material.dart';

class ItemValor {
  int valor;
  String texto;
  int rango;
  String color;
  String imgSrc;

  ItemValor({
    this.valor,
    @required this.texto,
    this.rango,
    this.color,
    this.imgSrc,
  });
}
