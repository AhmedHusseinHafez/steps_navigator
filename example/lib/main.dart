import 'package:flutter/material.dart';
import 'package:example/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MaterialApp(title: 'Flutter Demo', theme: _theme(), home: Home()));
}

ThemeData _theme() {
  return ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.black));
}
