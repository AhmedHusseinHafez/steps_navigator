import 'package:flutter/material.dart';
import 'package:expamle/home/home.dart';

void main() {
  // Bloc.observer = MyBlocObserver();
  runApp(MaterialApp(title: 'Flutter Demo', theme: _theme(), home: Home()));
}

ThemeData _theme() {
  return ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black));
}
