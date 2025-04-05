import 'package:flutter/material.dart';

class StepProgressWithSpacing extends StatelessWidget {
  final int totalSteps;
  final double currentStep;
  final double stepHeight;
  final double spacing;

  const StepProgressWithSpacing({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.stepHeight = 10.0,
    this.spacing = 10.0,
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
                    color: Colors.red,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width:
                        (stepWidth - ((index < totalSteps - 1) ? spacing : 0)) *
                        stepProgress,
                    height: stepHeight,
                    color: Colors.amber,
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
