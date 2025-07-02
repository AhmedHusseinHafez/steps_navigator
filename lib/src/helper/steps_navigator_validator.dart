import 'package:flutter/widgets.dart';
import 'package:steps_navigator_v2/src/logic/steps_flow_cubit.dart';
import 'package:steps_navigator_v2/src/logic/step_configuration_v2.dart';

/// A helper class for validating StepsNavigator constructor parameters
class StepsNavigatorValidator {
  static void validate({
    required List<
      Widget Function(
        StepsFlowState state,
        void Function({bool? isNextEnabled, bool? isBackEnabled})
        updateButtonStates,
      )
    >
    screens,
    required List<int> subStepsPerStepPattern,
    required int initialPage,
    required Map<int, StepConfiguration> stepConfigurations,
  }) {
    if (screens.isEmpty) {
      throw Exception('Screens list cannot be empty');
    }

    if (subStepsPerStepPattern.isEmpty) {
      throw Exception('SubStepsPerStepPattern list cannot be empty');
    }

    final totalSubSteps = subStepsPerStepPattern.fold<int>(
      0,
      (sum, count) => sum + count,
    );

    if (screens.length != totalSubSteps) {
      throw Exception(
        'Screens list length (${screens.length}) must match total sub-steps ($totalSubSteps)',
      );
    }

    if (initialPage < 0 || initialPage >= screens.length) {
      throw Exception(
        'Initial page ($initialPage) must be between 0 and ${screens.length - 1}',
      );
    }

    // Validate step configurations
    for (final entry in stepConfigurations.entries) {
      if (entry.key < 1 || entry.key > subStepsPerStepPattern.length) {
        throw Exception(
          'Step configuration key (${entry.key}) must be between 1 and ${subStepsPerStepPattern.length}',
        );
      }
    }
  }
}
