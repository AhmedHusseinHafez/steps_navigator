import 'package:flutter/material.dart';

class StepProgressWithSpacing extends StatelessWidget {
  final int totalSteps;
  final double currentStep;
  final double stepHeight;
  final double spacing;
  final Color? stepColor;
  final Color? progressColor;
  final Curve? progressCurve;
  final Duration? progressMoveDuration;

  const StepProgressWithSpacing({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.stepHeight = 10.0,
    this.spacing = 10.0,
    this.stepColor,
    this.progressColor,
    this.progressCurve,
    this.progressMoveDuration,
  });

  @override
  Widget build(BuildContext context) {
    double stepWidth = (MediaQuery.sizeOf(context).width / totalSteps);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(totalSteps, (index) {
        double stepProgress = (currentStep - index).clamp(0, 1).toDouble();

        return SizedBox(
          width: stepWidth,
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: stepWidth - ((index < totalSteps - 1) ? spacing : 0),
                    height: stepHeight,

                    color: stepColor ?? Colors.grey[300],
                  ),
                  AnimatedContainer(
                    curve: progressCurve ?? Curves.linear,
                    duration:
                        progressMoveDuration ??
                        const Duration(milliseconds: 300),
                    width:
                        (stepWidth - ((index < totalSteps - 1) ? spacing : 0)) *
                        stepProgress,
                    height: stepHeight,

                    color: progressColor ?? Colors.blue,
                  ),
                ],
              ),
              if (index < totalSteps - 1) SizedBox(width: spacing),
            ],
          ),
        );
      }),
    );
  }
}
