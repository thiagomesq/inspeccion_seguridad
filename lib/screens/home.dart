import 'package:flutter/material.dart';
import 'package:flutter/services.Dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/logo_paracel.jpg',
            filterQuality: FilterQuality.high,
            width: 200.0,
            height: 200.0,
          ),
        ],
      ),
    );
  }
}
