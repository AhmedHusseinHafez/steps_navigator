import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:steps_navigator_v2/steps_navigator_v2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isNextEnabled = true;
  bool _isBackEnabled = true;
  String _stepData = 'This is step one data';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final subStepsPerStepPattern = [4, 5, 6];
    return Scaffold(
      body: StepsNavigatorV2(
        onValidate: (direction, step, subStep) async {
          // Simulate network delay
          // if (direction == NavigationDirection.backward) {
          //   if (step == 1) {
          //     await Future.delayed(const Duration(seconds: 1));
          //     _stepOneData = 'Step one data loaded successfully';
          //     return _stepOneData.isNotEmpty;
          //   }
          //   return true;
          // }
          return true;
        },
        initialPage: 0,
        debounceDuration: const Duration(milliseconds: 100),

        // stepConfigurations: {
        //   1: StepConfiguration(
        //     subStepConfigurations: {
        //       2: SubStepConfiguration(
        //         // skipValidation: true,
        //         customBackButton: IconButton(
        //           onPressed: () {},
        //           icon: Icon(Icons.arrow_back, color: Colors.red),
        //         ),
        //       ),
        //     },

        //     // customBackButton: IconButton(
        //     //   onPressed: () {},
        //     //   icon: Icon(Icons.arrow_back),
        //     // ),
        //     // customNextButton: IconButton(
        //     //   onPressed: () {},
        //     //   icon: Icon(Icons.arrow_forward),
        //     // ),
        //     customEnter: (direction, step, subStep) async {
        //       log('customEnter: $direction, $step, $subStep');
        //     },
        //     customExit: (direction, step, subStep) async {
        //       log('customExit: $direction, $step, $subStep');
        //     },
        //     // skipValidation: false,
        //     // disableBackButton: false,
        //     // disableNextButton: false,
        //   ),
        // },
        onScreenExit: (direction, step, subStep) async {
          // await Future.delayed(const Duration(seconds: 5));

          log('onScreenExit: $direction, $step, $subStep');
        },
        onStepComplete: (step) async {
          log('onStepComplete: $step');
        },

        onFlowComplete: () async {
          log('Flow completed!');
        },
        onScreenEnter: (direction, step, subStep) async {
          // switch (subStep) {
          //   case 1:
          //     await Future.delayed(const Duration(seconds: 5));
          //     _stepData = "This is step one data";
          //     break;
          //   case 2:
          //     await Future.delayed(const Duration(seconds: 5));
          //     _stepData = "This is step two data";
          //     break;
          //   case 3:
          // }

          log('onScreenEnter: $direction, $step, $subStep');
        },
        subStepsPerStepPattern: subStepsPerStepPattern,
        padding: EdgeInsets.symmetric(horizontal: 15),
        progressColor: Colors.green,
        // stepColor: Colors.lime,
        spacing: 8,
        stepHeight: 9,

        onSubStepChanged: (step, subStep) {
          debugPrint('Current Step: $step, Current SubStep: $subStep');
        },
        customBackButton: TextButton.icon(
          onPressed: () {
            log('customBackButton: pressed');
          }, // The actual navigation is handled internally
          icon: Icon(Icons.arrow_back),
          label: Text('Go Back'),
        ),
        customNextButton: ElevatedButton.icon(
          onPressed: () {
            log('customNextButton: pressed');
          }, // The actual navigation is handled internally
          icon: Icon(Icons.arrow_forward),
          label: Text('Continue'),
        ),
        appBar: AppBar(title: const Text("Steps Navigator")),
        screens: List.generate(
          subStepsPerStepPattern.fold<int>(0, (sum, count) => sum + count),
          (index) => (state, updateButtonStates) {
            log('index: $index');
            // updateButtonStates is now only called for the visible screen
            // so we can safely call it here without causing unnecessary rebuilds
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
                  const SizedBox(height: 20),
                  Text(_stepData, style: TextStyle(color: Colors.amber)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
