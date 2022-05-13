import 'package:flutter/material.dart';

import '../models/item_valor.dart';
import '../constants.dart';

class ItemConfigWidget extends StatefulWidget {
  final ItemValor itemValor;
  final Function obtenerValor;

  ItemConfigWidget({this.itemValor, this.obtenerValor});
  @override
  _ItemConfigWidgetState createState() => _ItemConfigWidgetState();
}

class _ItemConfigWidgetState extends State<ItemConfigWidget> {
  var icon;
  var color;
  var imagen;

  @override
  Widget build(BuildContext context) {
    switch (widget.itemValor.rango) {
      case 1:
        icon = Icon(Icons.sentiment_very_satisfied);
        break;
      case 2:
        icon = Icon(Icons.sentiment_satisfied_alt);
        break;
      case 3:
        icon = Icon(Icons.sentiment_neutral_outlined);
        break;
      case 4:
        icon = Icon(Icons.sentiment_very_dissatisfied);
        break;
      default:
        icon = null;
    }

    if (widget.itemValor.color == "Blanco") {
      color = blancoPrimario;
    } else if (widget.itemValor.color == "Rojo") {
      color = rojoPrimario;
    } else if (widget.itemValor.color == "Azul") {
      color = azulPrimario;
    } else {
      color = blancoPrimario;
    }
    // else if (widget.itemValor.color == "Engrane") {
    //   imagen = widget.itemValor.imgSrc;
    // } else if (widget.itemValor.color == "Crashed") {

    // }

    imagen = widget.itemValor.imgSrc;

    if (widget.itemValor.valor == 2000)
      return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: color,
          ),
        ),
        title: Text(widget.itemValor.color),
        trailing: icon,
        onTap: () {
          widget.obtenerValor();
        },
      );

    if (widget.itemValor.valor == 3000)
      return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        leading: Container(
          width: 30,
          height: 30,
          child: Image.asset(
            imagen,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget.itemValor.color),
        trailing: icon,
        onTap: () {
          widget.obtenerValor();
        },
      );

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      leading: Text(widget.itemValor.valor.toString()),
      title: Text(widget.itemValor.texto.toString()),
      trailing: icon,
      onTap: () {
        widget.obtenerValor();
      },
    );
  }
}
