import 'package:flutter/material.dart';
import 'package:steps_navigator/widgets/step_progress_with_spacing.dart';

class StepsNavBar extends StatelessWidget {
  const StepsNavBar({
    super.key,
    required this.totalSteps,
    required this.currentSubStep,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentStep,
  });

  final int totalSteps;
  final int currentSubStep;
  final int currentStep;

  final Function() onBackPressed;
  final Function() onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 17,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        StepProgressWithSpacing(
          totalSteps: 3,
          currentStep: _calculateCurrentStepFactor(currentSubStep),
          stepHeight: 5,
          spacing: 6,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onBackPressed,
                child: Text(
                  "Back",
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              _buildButton(context),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateCurrentStepFactor(currentSubStep) {
    if (currentStep == 1) {
      return currentSubStep * 0.25;
    } else {
      return (currentSubStep * 0.2) + 0.2;
    }
  }

  Widget _buildButton(context) {
    return ElevatedButton(onPressed: onNextPressed, child: Text("Next"));
  }
}
