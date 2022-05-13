import 'package:flutter/material.dart';
import 'package:app_flutter_nothing/screens/home_screen.dart';

import './constants.dart';

// SCREENS
import './screens/configuracion_screen.dart';
import './main.dart';

class Rutas {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        final args = settings.arguments as Map<String, Object>;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            idStorage: args['id'],
            configuracionClicksStorage: args['configuracionClicks'],
            crazyCellStorage: args['crazyCell'],
            configuracionLongPressStorage: args['configuracionLongPress'],
            configuracionColorStorage: args['configuracionColor'],
            configuracionImagenStorage: args['configuracionImagen'],
            verImagenStorage: args['verImagen'],
          ),
        );
        break;
      case configuracionScreenRoute:
        return MaterialPageRoute(builder: (_) => ConfiguracionScreen());
        break;
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MyApp());
        break;
      default:
        return MaterialPageRoute(builder: (_) => ConfiguracionScreen());
    }
  }
}
