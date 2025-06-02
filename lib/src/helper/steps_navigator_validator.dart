import 'package:flutter/widgets.dart';
import 'package:steps_navigator/src/logic/steps_flow_cubit.dart';

/// A helper class for validating StepsNavigator constructor parameters
class StepsNavigatorValidator {
  static void validate({
    required List<Widget Function(StepsFlowState state, void Function({bool? isNextEnabled, bool? isBackEnabled}) updateButtonStates)> screens,
    // required int totalSteps,
    required List<int> subStepsPerStepPattern,
    required int initialPage,
  }) {
    final totalSubSteps = subStepsPerStepPattern.fold<int>(0, (sum, count) => sum + count);
    
    if (screens.length != totalSubSteps) {
      throw AssertionError(
        'Expected screens length (${screens.length}) to equal total sub-steps ($totalSubSteps)',
      );
    }

    if (initialPage < 0 || initialPage >= totalSubSteps) {
      throw AssertionError(
        'Initial page ($initialPage) must be between 0 and ${totalSubSteps - 1}',
      );
    }
  }
}
