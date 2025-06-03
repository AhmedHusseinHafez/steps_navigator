import 'package:flutter/material.dart';
import 'package:steps_navigator/src/widgets/step_progress_with_spacing.dart';
import 'package:steps_navigator/src/logic/steps_flow_cubit.dart';
import 'package:steps_navigator/src/logic/navigation_direction.dart';

class StepsNavBar extends StatelessWidget {
  const StepsNavBar({
    super.key,
    required this.currentSubStep,
    required this.currentStep,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.subStepsPerStep,
    required this.state,
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

  final int currentSubStep;
  final int currentStep;
  final List<int> subStepsPerStep;
  final StepsFlowState state;
  final EdgeInsetsGeometry? padding;
  final Widget? customBackButton;
  final Widget? customNextButton;
  final Future<void> Function()? onBackPressed;
  final Future<void> Function()? onNextPressed;
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
          totalSteps: subStepsPerStep.length,
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
            children: [_buildBackButton(context), _buildNextButton(context)],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    final isLoading =
        state.isLoading &&
        state.loadingDirection == NavigationDirection.backward;
    final onPressed =
        (!state.isBackEnabled || isLoading) ? null : () async {
          if (onBackPressed != null) {
            await onBackPressed!();
          }
        };

    if (customBackButton != null) {
      if (customBackButton is TextButton) {
        final button = customBackButton as TextButton;
        return TextButton(
          onPressed: onPressed,
          style: button.style,
          child:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : button.child ?? const SizedBox(),
        );
      } else if (customBackButton is ElevatedButton) {
        final button = customBackButton as ElevatedButton;
        return ElevatedButton(
          onPressed: onPressed,
          style: button.style,
          child:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : button.child ?? const SizedBox(),
        );
      } else if (customBackButton is IconButton) {
        final button = customBackButton as IconButton;
        return IconButton(
          onPressed: onPressed,
          icon:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : button.icon,
          color: button.color,
          iconSize: button.iconSize,
        );
      }
      return customBackButton!;
    }

    return TextButton(
      onPressed: onPressed,
      child:
          isLoading
              ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
              : Text(
                "Back",
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final isLoading =
        state.isLoading &&
        state.loadingDirection == NavigationDirection.forward;
    final onPressed =
        (!state.isNextEnabled || isLoading) ? null : () async {
          if (onNextPressed != null) {
            await onNextPressed!();
          }
        };

    if (customNextButton != null) {
      if (customNextButton is TextButton) {
        final button = customNextButton as TextButton;
        return TextButton(
          onPressed: onPressed,
          style: button.style,
          child:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : button.child ?? const SizedBox(),
        );
      } else if (customNextButton is ElevatedButton) {
        final button = customNextButton as ElevatedButton;
        return ElevatedButton(
          onPressed: onPressed,
          style: button.style,
          child:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : button.child ?? const SizedBox(),
        );
      } else if (customNextButton is IconButton) {
        final button = customNextButton as IconButton;
        return IconButton(
          onPressed: onPressed,
          icon:
              isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : button.icon,
          color: button.color,
          iconSize: button.iconSize,
        );
      }
      return customNextButton!;
    }

    return ElevatedButton(
      onPressed: onPressed,
      child:
          isLoading
              ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
              : Text("Next"),
    );
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
