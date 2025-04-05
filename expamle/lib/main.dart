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
    const totalSteps = 4;
    const subStepsPerStep = [3, 4, 2, 5]; // Custom substeps for each step
    final totalSubSteps = subStepsPerStep.reduce((a, b) => a + b);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: Scaffold(
        body: StepsNavigator(
          subStepsPerStep: subStepsPerStep,

          padding: EdgeInsets.symmetric(horizontal: 15),
          progressColor: Colors.green,
          stepColor: Colors.lime,
          spacing: 8,
          stepHeight: 9,
          onSubStepChanged: (step, subStep) {
            debugPrint('Current Step: $step, Current SubStep: $subStep');
          },
          isOnNextButtonEnabled: false,
          customNextButton: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              debugPrint('Next button pressed');
            },
          ),

          appBar: AppBar(title: const Text("Steps Navigator")),
          totalSubSteps: totalSubSteps,
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
          totalSteps: totalSteps,
        ),
      ),
    );
  }
}
