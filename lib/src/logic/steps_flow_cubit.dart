import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'navigation_direction.dart';
import 'step_configuration.dart';

part 'steps_flow_cubit.freezed.dart';
part 'steps_flow_state.dart';

class StepsFlowCubit extends Cubit<StepsFlowState> {
  StepsFlowCubit({
    required this.subStepsPerStepPattern,
    this.onSubStepChanged,
    this.onValidate,
    this.onScreenEnter,
    this.onScreenExit,
    this.onStepComplete,
    this.onFlowComplete,
    this.stepConfigurations = const {},
    int initialSubStep = 1,
  }) : super(
         StepsFlowState(
           currentStep: _determineStep(initialSubStep, subStepsPerStepPattern),
           currentSubStep: initialSubStep,
         ),
       );

  final List<int> subStepsPerStepPattern;
  final void Function(int step, int subStep)? onSubStepChanged;
  final Future<bool> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? onValidate;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? onScreenEnter;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? onScreenExit;
  final Future<void> Function(int step)? onStepComplete;
  final Future<void> Function()? onFlowComplete;
  final Map<int, StepConfiguration> stepConfigurations;

  Future<void> onProcess(
    NavigationDirection direction,
    int step,
    int subStep,
  ) async {
    final currentStep = state.currentStep;
    final currentSubStep = state.currentSubStep;
    final totalSubSteps = subStepsPerStepPattern.fold<int>(
      0,
      (sum, count) => sum + count,
    );
    final incrementNewSubStep = (currentSubStep + 1).clamp(1, totalSubSteps);
    final decrementNewSubStep = (currentSubStep - 1).clamp(1, totalSubSteps);
    final newNextStep = _determineStep(
      incrementNewSubStep,
      subStepsPerStepPattern,
    );
    final newBackStep = _determineStep(
      decrementNewSubStep,
      subStepsPerStepPattern,
    );

    if (direction == NavigationDirection.forward) {
      // Get step configuration if available
      final stepConfig = stepConfigurations[currentStep];
      final subStepConfig = stepConfig?.getSubStepConfiguration(currentSubStep);

      // Skip validation if configured
      if (!(subStepConfig?.skipValidation ?? stepConfig?.skipValidation ?? false)) {
        if (onValidate != null) {
          emit(state.copyWith(isLoading: true, loadingDirection: direction));
          final isValid = await onValidate!(
            direction,
            currentStep,
            currentSubStep,
          );
          emit(state.copyWith(isLoading: false, loadingDirection: null));
          if (!isValid) return;
        }
      }

      // Call custom exit if available
      if (subStepConfig?.customExit != null) {
        await subStepConfig!.customExit!(direction, currentStep, currentSubStep);
      } else if (stepConfig?.customExit != null) {
        await stepConfig!.customExit!(direction, currentStep, currentSubStep);
      } else if (onScreenExit != null) {
        await onScreenExit!(direction, currentStep, currentSubStep);
      }

      onSubStepChanged?.call(currentStep, incrementNewSubStep);
      emit(
        StepsFlowState(
          currentStep: newNextStep,
          currentSubStep: incrementNewSubStep,
        ),
      );

      // Check if we completed a step
      if (currentStep != newNextStep && onStepComplete != null) {
        await onStepComplete!(currentStep);
      }

      // Check if we completed the flow
      if (incrementNewSubStep == totalSubSteps && onFlowComplete != null) {
        await onFlowComplete!();
      }

      // Call custom enter if available
      final nextStepConfig = stepConfigurations[newNextStep];
      final nextSubStepConfig = nextStepConfig?.getSubStepConfiguration(incrementNewSubStep);

      if (nextSubStepConfig?.customEnter != null) {
        await nextSubStepConfig!.customEnter!(direction, newNextStep, incrementNewSubStep);
      } else if (nextStepConfig?.customEnter != null) {
        await nextStepConfig!.customEnter!(direction, newNextStep, incrementNewSubStep);
      } else {
        await onScreenEnterProcess(newNextStep, incrementNewSubStep);
      }
    } else if (direction == NavigationDirection.backward) {
      // Get step configuration if available
      final stepConfig = stepConfigurations[currentStep];
      final subStepConfig = stepConfig?.getSubStepConfiguration(currentSubStep);

      // Skip validation if configured
      if (!(subStepConfig?.skipValidation ?? stepConfig?.skipValidation ?? false)) {
        if (onValidate != null) {
          emit(state.copyWith(isLoading: true, loadingDirection: direction));
          final isValid = await onValidate!(
            direction,
            currentStep,
            currentSubStep,
          );
          emit(state.copyWith(isLoading: false, loadingDirection: null));
          if (!isValid) return;
        }
      }

      // Call custom exit if available
      if (subStepConfig?.customExit != null) {
        await subStepConfig!.customExit!(direction, currentStep, currentSubStep);
      } else if (stepConfig?.customExit != null) {
        await stepConfig!.customExit!(direction, currentStep, currentSubStep);
      } else if (onScreenExit != null) {
        await onScreenExit!(direction, currentStep, currentSubStep);
      }

      onSubStepChanged?.call(currentStep, decrementNewSubStep);
      emit(
        StepsFlowState(
          currentStep: newBackStep,
          currentSubStep: decrementNewSubStep,
        ),
      );

      // Call custom enter if available
      final backStepConfig = stepConfigurations[newBackStep];
      final backSubStepConfig = backStepConfig?.getSubStepConfiguration(decrementNewSubStep);

      if (backSubStepConfig?.customEnter != null) {
        await backSubStepConfig!.customEnter!(direction, newBackStep, decrementNewSubStep);
      } else if (backStepConfig?.customEnter != null) {
        await backStepConfig!.customEnter!(direction, newBackStep, decrementNewSubStep);
      } else {
        await onScreenEnterProcess(newBackStep, decrementNewSubStep);
      }
    }
  }

  static int _determineStep(int subStep, List<int> subStepsPerStepPattern) {
    int cumulativeSubSteps = 0;
    for (int i = 0; i < subStepsPerStepPattern.length; i++) {
      cumulativeSubSteps += subStepsPerStepPattern[i];
      if (subStep <= cumulativeSubSteps) {
        return i + 1;
      }
    }
    return subStepsPerStepPattern.length; // Fallback
  }

  void updateButtonStates({bool? isNextEnabled, bool? isBackEnabled}) {
    emit(
      state.copyWith(
        isNextEnabled: isNextEnabled ?? state.isNextEnabled,
        isBackEnabled: isBackEnabled ?? state.isBackEnabled,
      ),
    );
  }

  Future<void> onScreenEnterProcess(int stepIndex, int subStepIndex) async {
    if (onScreenEnter != null) {
      await onScreenEnter!(
        state.loadingDirection ?? NavigationDirection.forward,
        stepIndex,
        subStepIndex,
      );
    }
  }
}
