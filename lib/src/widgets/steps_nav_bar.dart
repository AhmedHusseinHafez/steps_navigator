import 'package:flutter/material.dart';
import 'package:steps_navigator/src/widgets/step_progress_with_spacing.dart';

class StepsNavBar extends StatelessWidget {
  const StepsNavBar({
    super.key,
    required this.totalSteps,
    required this.currentSubStep,
    required this.currentStep,
    required this.onBackPressed,
    required this.onNextPressed,
    this.padding,
    this.customBackButton,
    this.customNextButton,
    this.stepColor,
    this.progressColor,
    this.progressCurve,
    this.progressMoveDuration,
    this.stepHeight,
    this.spacing,
    this.spaceBetweenButtonAndSteps,
  });

  final int totalSteps;
  final int currentSubStep;
  final int currentStep;

  final EdgeInsetsGeometry? padding;
  final Widget? customBackButton;
  final Widget? customNextButton;

  final Function() onBackPressed;
  final Function() onNextPressed;

  final Color? stepColor;
  final Color? progressColor;
  final Curve? progressCurve;
  final Duration? progressMoveDuration;
  final double? stepHeight;
  final double? spacing;
  final double? spaceBetweenButtonAndSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spaceBetweenButtonAndSteps ?? 17,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        StepProgressWithSpacing(
          totalSteps: totalSteps,
          currentStep: _calculateCurrentStepFactor(currentSubStep),
          stepHeight: stepHeight ?? 5,
          spacing: spacing ?? 6,
          progressColor: progressColor,
          stepColor: stepColor,
          progressCurve: progressCurve,
          progressMoveDuration: progressMoveDuration,
        ),
        Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customBackButton ??
                  TextButton(
                    onPressed: onBackPressed,
                    child: Text(
                      "Back",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
              customNextButton ??
                  ElevatedButton(onPressed: onNextPressed, child: Text("Next")),
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
}
