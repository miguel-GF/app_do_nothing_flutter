import 'package:flutter/material.dart';

class NormalContainerWidget extends StatelessWidget {
  final imagen;
  final String configuracionImagenStorage;
  final int verImagenStorage;

  NormalContainerWidget({
    this.imagen,
    this.configuracionImagenStorage,
    this.verImagenStorage,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: verImagenStorage == 2
            ? DecorationImage(
                image: AssetImage(configuracionImagenStorage),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}
