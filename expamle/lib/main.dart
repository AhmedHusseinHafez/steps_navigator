import 'package:flutter/material.dart';
import 'package:steps_navigator/steps_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: Scaffold(
        body: StepsMainScreen(
          padding: EdgeInsets.symmetric(horizontal: 15),
          progressColor: Colors.green,
          stepColor: Colors.lime,
          spacing: 8,
          stepHeight: 9,
          // customNextButton: Icon(Icons.arrow_forward),
          appBar: AppBar(title: const Text("Steps Navigator")),
          totalSubSteps: 14,
          screens: [
            const Center(child: Text("Step 1")),
            const Center(child: Text("Step 2")),
            const Center(child: Text("Step 3")),
            const Center(child: Text("Step 4")),
            const Center(child: Text("Step 5")),
            const Center(child: Text("Step 6")),
            const Center(child: Text("Step 7")),

            const Center(child: Text("Step 8")),
            const Center(child: Text("Step 9")),
            const Center(child: Text("Step 10")),
            const Center(child: Text("Step 11")),
            const Center(child: Text("Step 12")),
            const Center(child: Text("Step 13")),
            const Center(child: Text("Step 14")),
          ],
          totalSteps: 3,
        ),
      ),
    );
  }
}
