import 'package:flutter/material.dart';

class OpcionPrincipalWidget extends StatefulWidget {
  final icono;
  final titulo;
  final descripcion;
  final textoCaption;
  final imagenSrc;
  final Function getAction;

  OpcionPrincipalWidget({
    this.icono,
    this.titulo,
    this.descripcion,
    this.textoCaption,
    this.imagenSrc,
    this.getAction,
  });
  @override
  _OpcionPrincipalWidgetState createState() => _OpcionPrincipalWidgetState();
}

class _OpcionPrincipalWidgetState extends State<OpcionPrincipalWidget> {
  @override
  Widget build(BuildContext context) {
    
    var icono;
    switch (widget.icono) {
      case 1:
        icono = Icon(Icons.settings_cell, size: 30);
        break;
      default:
        icono = Icon(Icons.settings_cell, size: 30);
    }

    return GestureDetector(
      onTap: widget.getAction,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        padding: EdgeInsets.only(bottom: 10, top: 5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.titulo,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              alignment: Alignment.center,
              child: ListTile(
                leading: widget.icono != 1
                    ? Image.asset(
                        widget.imagenSrc,
                        width: 30,
                      )
                    : icono,
                title: Text(
                  widget.descripcion,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  widget.textoCaption,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
