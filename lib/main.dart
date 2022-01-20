import 'package:flutter/material.dart';
import 'views/widgets/choose_location.dart';
import 'views/widgets/loading.dart';
import 'views/home.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation()
    }));
