import 'package:flutter/material.dart';
import 'navigation_direction.dart';

/// Configuration for individual sub-steps in the navigation flow
class SubStepConfiguration {
  const SubStepConfiguration({
    this.skipValidation = false,
    this.disableBackButton = false,
    this.disableNextButton = false,
    this.customBackButton,
    this.customNextButton,
    this.customEnter,
    this.customExit,
  });

  final bool skipValidation;
  final bool disableBackButton;
  final bool disableNextButton;
  final Widget? customBackButton;
  final Widget? customNextButton;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? customEnter;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? customExit;
}

/// Configuration for individual steps in the navigation flow
class StepConfiguration {
  const StepConfiguration({
    this.skipValidation = false,
    this.disableBackButton = false,
    this.disableNextButton = false,
    this.customBackButton,
    this.customNextButton,
    this.customEnter,
    this.customExit,
    this.subStepConfigurations = const {},
  });

  final bool skipValidation;
  final bool disableBackButton;
  final bool disableNextButton;
  final Widget? customBackButton;
  final Widget? customNextButton;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? customEnter;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? customExit;
  
  /// Map of sub-step configurations where the key is the sub-step number (1-based)
  /// and the value is the configuration for that sub-step
  final Map<int, SubStepConfiguration> subStepConfigurations;

  /// Creates a map of step configurations where the key is the step number (1-based)
  /// and the value is the configuration for that step.
  static Map<int, StepConfiguration> createStepConfigurations({
    Map<int, StepConfiguration>? configurations,
  }) {
    return configurations ?? {};
  }

  /// Gets the configuration for a specific sub-step, falling back to step configuration if not specified
  SubStepConfiguration? getSubStepConfiguration(int subStep) {
    return subStepConfigurations[subStep];
  }
} 