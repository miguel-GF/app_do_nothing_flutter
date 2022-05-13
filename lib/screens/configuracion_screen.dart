import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widgets/item_config_widget.dart';
import '../widgets/opcion_principal_widget.dart';
import '../models/item_valor.dart';
import '../services/configuraciones.dart';

class ConfiguracionScreen extends StatefulWidget {
  @override
  _ConfiguracionScreenState createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  var _id;
  var _configuracionClicks;
  var _crazyCell;
  var _valLongPress;
  var _valTheme;
  bool _isLoading = false;
  var _tipo = 0;
  var _valoresLongPress;
  var _valoresThemes;

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = prefs.getString('id');
      _configuracionClicks = prefs.getInt('configuracionClicks');
      _crazyCell = prefs.getBool('crazyCell');
    });
    Navigator.pushNamed(context, homeScreenRoute, arguments: {
      'id': _id,
      'configuracionClicks': _configuracionClicks,
      'crazyCell': _crazyCell,
    });
  }

  Future setData({
    String id,
    int configuracionClicks,
  }) async {
    if (_valTheme == null)
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'No ha seleccionado su tema',
          textAlign: TextAlign.center,
        ),
      ));
    if (_tipo <= 0)
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'No ha seleccionado tipo de configuración',
          textAlign: TextAlign.center,
        ),
      ));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setInt('configuracionClicks',    configuracionClicks);
    prefs.setInt('configuracionLongPress', _valLongPress);
    prefs.setString('configuracionColor',  _valTheme['color']);
    prefs.setString('configuracionImagen', _valTheme['imgSrc']);
    prefs.setInt('verImagen',               _valTheme['valor']);
    if(_valTheme['valor'] == 1) prefs.remove('configuracionImagen');
    var crazyCell = _tipo == 1 ? true : false;
    prefs.setBool('crazyCell', crazyCell);
    // Navigator.pushNamed(context, homeScreenRoute, arguments: {
    //   'id': id,
    //   'configuracionClicks': configuracionClicks,
    //   'configuracionLongPress': _valLongPress,
    //   'configuracionColor': _valTheme,
    //   'crazyCell': crazyCell,
    // });
    Navigator.pushReplacementNamed(context, mainRoute);
  }

  Future _obtenerValorLongPress(valor) async {
    setState(() {
      _valLongPress = valor["valor"];
    });
  }

  Future _obtenerValorTheme(valor) async {
    setState(() {
      _valTheme = valor;
    });
  }

  Future showLoading() async {
    setState(() {
      _valoresLongPress = [];
      _isLoading = !_isLoading;
      _valoresLongPress = Configuraciones.obtenerValoresLongPress();
      _valoresThemes = Configuraciones.obtenerValoresThemes();
    });
  }

  Future<void> showModal(int tipo) async {
    setState(() {
      _tipo = tipo;
    });
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        builder: (cxt) {
          return FractionallySizedBox(
              heightFactor: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          tileColor: Theme.of(context).accentColor,
                          title: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              _tipo == 1 ? 'Crazy Cell @_@' : 'Do Nothing',
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            iconSize: 18,
                            splashRadius: 18,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: const Text('Elija una opción'),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _valoresLongPress.length,
                            itemBuilder: (ctx, index) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: <Widget>[
                                  ItemConfigWidget(
                                    itemValor: ItemValor(
                                      valor: _valoresLongPress[index]["valor"],
                                      texto: _valoresLongPress[index]["texto"],
                                      rango: _valoresLongPress[index]["rango"],
                                    ),
                                    obtenerValor: () => _obtenerValorLongPress(
                                            _valoresLongPress[index])
                                        .then((value) =>
                                            Navigator.of(context).pop()),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/images/long_press.png",
                              width: 30,
                            ),
                            title: const Text(
                              "Número de veces para abrir configuraciones",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            subtitle: const Text(
                              "Mantener pulsado",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            trailing: const Text(
                              "*",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  Future<void> showModalScreen() async {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        builder: (cxt) {
          return FractionallySizedBox(
              heightFactor: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          tileColor: Theme.of(context).accentColor,
                          title: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: const Text('Themes'),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            iconSize: 18,
                            splashRadius: 18,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: const Text('Elija una opción'),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _valoresThemes.length,
                            itemBuilder: (ctx, index) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: <Widget>[
                                  ItemConfigWidget(
                                    itemValor: ItemValor(
                                      valor: index > 2 ? 3000 : 2000,
                                      rango: 0,
                                      color: _valoresThemes[index]["color"],
                                      texto: "",
                                      imgSrc: _valoresThemes[index]["imgSrc"],
                                    ),
                                    obtenerValor: () => _obtenerValorTheme(
                                            _valoresThemes[index])
                                        .then((value) =>
                                            Navigator.of(context).pop()),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.settings_cell, size: 30),
                            title: const Text(
                              "Fondo de tu pantalla",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            subtitle: null,
                            trailing: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQ = MediaQuery.of(context).size;

    Widget principal() => Scaffold(
        bottomNavigationBar: Container(
          width: double.infinity,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Guardar Configuración',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            onPressed: () {
              setData(
                id: UniqueKey().toString(),
                configuracionClicks: 10,
              );
            },
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Configuraciones',
                style: Theme.of(context).textTheme.headline1,
              ),
              expandedHeight: mediaQ.height * 0.2,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.asset("assets/images/engrane.jpg",
                        width: mediaQ.width, fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 20,
                    bottom: 20,
                  ),
                  
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text('Pantalla'),
                    ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 10,
                    bottom: 5,
                  ),
                  child: OpcionPrincipalWidget(
                    icono: 1,
                    titulo: "Themes",
                    descripcion: "Selección del fondo de tu pantalla",
                    textoCaption: "",
                    imagenSrc: "assets/images/crazy.png",
                    getAction: () => showLoading().then((_) {
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => showModalScreen())
                          .then((_) => setState(() {
                                _isLoading = !_isLoading;
                              }));
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 20,
                    bottom: 20,
                  ),
                  
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text('Tipo configuración'),
                    ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 10,
                    bottom: 5,
                  ),
                  child: OpcionPrincipalWidget(
                    titulo: "Crazy cell @_@",
                    descripcion:
                        "Si seleccionas esta opción, sucederán eventos aleatorios en tu celular.",
                    textoCaption: "Eventos que sucederan al utilizar gestos como tap, double tap. No te espantes! :D",
                    imagenSrc: "assets/images/crazy.png",
                    getAction: () => showLoading().then((_) {
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => showModal(1))
                          .then((_) => setState(() {
                                _isLoading = !_isLoading;
                              }));
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 10,
                    bottom: 5,
                  ),
                  child: OpcionPrincipalWidget(
                    titulo: "Do nothing D=",
                    descripcion:
                        "Si seleccionas esta opción, literal no hara nada tu celular.",
                    textoCaption: "Que aburrido =/",
                    imagenSrc: "assets/images/bored.png",
                    getAction: () => showLoading().then((_) {
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => showModal(2))
                          .then((_) => setState(() {
                                _isLoading = !_isLoading;
                              }));
                    }),
                  ),
                ),
                if (_tipo == 1)
                  Text(
                    _valLongPress != null
                        ? "Crazy cell @_@: $_valLongPress veces long press..."
                        : "No a seleccionado ningun valor",
                    textAlign: TextAlign.center,
                  ),
                if (_tipo == 2)
                  Text(
                    _valLongPress != null
                        ? "Do nothing D=: $_valLongPress veces long press..."
                        : "No a seleccionado ningun valor",
                    textAlign: TextAlign.center,
                  ),
              ]),
            ),
          ],
        ));

    Widget loader() => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Configuraciones',
              style: Theme.of(context).textTheme.headline1,
            ),
            expandedHeight: mediaQ.height * 0.2,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("assets/images/engrane.jpg",
                  width: mediaQ.width, fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: mediaQ.height * 0.4),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          )
        ]));

    Widget checar() {
      if (_isLoading) return loader();

      return principal();
    }

    return checar();
  }
}
