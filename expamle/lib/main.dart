import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:steps_navigator/steps_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isNextEnabled = true;
  bool _isBackEnabled = true;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final subStepsPerStepPattern = [4, 5, 6];
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: Scaffold(
        body: StepsNavigator(
          onValidate: (direction, step, subStep) async {
            // Simulate network delay
            await Future.delayed(const Duration(seconds: 2));
            if (direction == NavigationDirection.forward) {
              return true;
            }
            return true;
          },
          initialPage: 0,

          stepConfigurations: {
            1: StepConfiguration(
              subStepConfigurations: {
                2: SubStepConfiguration(
                  skipValidation: true,
                  customBackButton: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back, color: Colors.red),
                  ),
                ),
              },

              customBackButton: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
              ),
              customNextButton: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
              ),
              customEnter: (direction, step, subStep) async {
                log('customEnter: $direction, $step, $subStep');
              },
              customExit: (direction, step, subStep) async {
                log('customExit: $direction, $step, $subStep');
              },
              skipValidation: false,
              // disableBackButton: false,
              // disableNextButton: false,
            ),
          },
          onScreenExit: (direction, step, subStep) async {
            log('onScreenExit: $direction, $step, $subStep');
          },
          onStepComplete: (step) async {
            log('onStepComplete: $step');
          },
          onFlowComplete: () async {
            log('Flow completed!');
          },
          onScreenEnter: (direction, step, subStep) async {
            log('onScreenEnter: $direction, $step, $subStep');
          },
          subStepsPerStepPattern: subStepsPerStepPattern,
          padding: EdgeInsets.symmetric(horizontal: 15),
          progressColor: Colors.green,
          stepColor: Colors.lime,
          spacing: 8,
          stepHeight: 9,

          onSubStepChanged: (step, subStep) {
            debugPrint('Current Step: $step, Current SubStep: $subStep');
          },
          customBackButton: TextButton.icon(
            onPressed: null, // The actual navigation is handled internally
            icon: Icon(Icons.arrow_back),
            label: Text('Go Back'),
          ),
          customNextButton: ElevatedButton.icon(
            onPressed: null, // The actual navigation is handled internally
            icon: Icon(Icons.arrow_forward),
            label: Text('Continue'),
          ),
          appBar: AppBar(title: const Text("Steps Navigator")),
          screens: List.generate(
            subStepsPerStepPattern.fold<int>(0, (sum, count) => sum + count),
            (index) => (state, updateButtonStates) {
              // Example: Disable next button on even steps, disable back button on first step
              updateButtonStates(
                isNextEnabled: _isNextEnabled,
                isBackEnabled: _isBackEnabled,
              );

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Next button: $_isNextEnabled"),
                    Switch(
                      value: _isNextEnabled,
                      onChanged: (value) {
                        setState(() {
                          _isNextEnabled = value;
                        });
                      },
                    ),
                    Text("Back button: $_isBackEnabled"),
                    Switch(
                      value: _isBackEnabled,
                      onChanged: (value) {
                        setState(() {
                          _isBackEnabled = value;
                        });
                      },
                    ),
                    Text(
                      "current step: ${state.currentStep} current sub step: ${state.currentSubStep}",
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Next button is ${state.isNextEnabled ? 'enabled' : 'disabled'}",
                      style: TextStyle(
                        color: state.isNextEnabled ? Colors.green : Colors.red,
                      ),
                    ),
                    Text(
                      "Back button is ${state.isBackEnabled ? 'enabled' : 'disabled'}",
                      style: TextStyle(
                        color: state.isBackEnabled ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
