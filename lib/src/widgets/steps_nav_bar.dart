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
    required this.subStepsPerStep,
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
  final List<int> subStepsPerStep;
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
          currentStep: _calculateCurrentStepFactor(),
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
            children: [_buildBackButton(), _buildNextButton()],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    if (customBackButton == null) {
      return TextButton(
        onPressed: onBackPressed,
        child: Text(
          "Back",
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
      );
    }

    return _wrapButtonWithCallback(
      button: customBackButton!,
      requiredCallback: onBackPressed,
    );
  }

  Widget _buildNextButton() {
    if (customNextButton == null) {
      return ElevatedButton(onPressed: onNextPressed, child: Text("Next"));
    }

    return _wrapButtonWithCallback(
      button: customNextButton!,
      requiredCallback: onNextPressed,
    );
  }

  Widget _wrapButtonWithCallback({
    required Widget button,
    required VoidCallback requiredCallback,
  }) {
    VoidCallback? customCallback;

    // Try to extract the onPressed callback from common button types
    if (button is ElevatedButton) {
      customCallback = button.onPressed;
    } else if (button is TextButton) {
      customCallback = button.onPressed;
    } else if (button is IconButton) {
      customCallback = button.onPressed;
    }

    // Combine the callbacks: customCallback (if exists) + requiredCallback
    combinedCallback() {
      customCallback?.call(); // Call the custom callback if it exists
      requiredCallback(); // Always call the required navigation callback
    }

    // Return a new button with the combined callback
    if (button is ElevatedButton) {
      return ElevatedButton(
        onPressed: combinedCallback,
        style: button.style,
        child: button.child,
      );
    } else if (button is TextButton) {
      return TextButton(
        onPressed: combinedCallback,
        style: button.style,
        child: button,
      );
    } else if (button is IconButton) {
      return IconButton(
        onPressed: combinedCallback,
        icon: button.icon,
        color: button.color,
        iconSize: button.iconSize,
      );
    }

    // Fallback: Wrap unknown widget types with GestureDetector
    return GestureDetector(onTap: combinedCallback, child: button);
  }

  double _calculateCurrentStepFactor() {
    int cumulativeSubSteps = 0;
    int totalPreviousSubSteps = 0;

    for (int i = 0; i < currentStep - 1; i++) {
      totalPreviousSubSteps += subStepsPerStep[i];
    }

    cumulativeSubSteps = currentSubStep - totalPreviousSubSteps;
    double stepFraction = cumulativeSubSteps / subStepsPerStep[currentStep - 1];
    return (currentStep - 1) + stepFraction;
  }
}
