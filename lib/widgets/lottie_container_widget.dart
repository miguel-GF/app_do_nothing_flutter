import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieContainerWidget extends StatefulWidget {
  final lottieUrl;
  final String configuracionImagenStorage;

  LottieContainerWidget({
    this.lottieUrl,
    this.configuracionImagenStorage,
  });

  @override
  _LottieContainerWidgetState createState() => _LottieContainerWidgetState();
}

class _LottieContainerWidgetState extends State<LottieContainerWidget> {
  var _container;

  @override
  Widget build(BuildContext context) {
    if (widget.configuracionImagenStorage == null)
      _container = Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Lottie.asset(
          widget.lottieUrl,
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      );
    else
      _container = Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.configuracionImagenStorage),
            fit: BoxFit.cover,
          ),
        ),
        child: Lottie.asset(
          widget.lottieUrl,
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      );

    return _container;
  }
}
