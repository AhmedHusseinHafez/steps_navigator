import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_direction_v2.dart';
import 'step_configuration_v2.dart';

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
    NavigationDirectionV2 direction,
    int step,
    int subStep,
  )?
  onValidate;
  final Future<void> Function(
    NavigationDirectionV2 direction,
    int step,
    int subStep,
  )?
  onScreenEnter;
  final Future<void> Function(
    NavigationDirectionV2 direction,
    int step,
    int subStep,
  )?
  onScreenExit;
  final Future<void> Function(int step)? onStepComplete;
  final Future<void> Function()? onFlowComplete;
  final Map<int, StepConfiguration> stepConfigurations;

  Future<void> onProcess(
    NavigationDirectionV2 direction,
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

    if (direction == NavigationDirectionV2.forward) {
      // Get step configuration if available
      final stepConfig = stepConfigurations[currentStep];
      final subStepConfig = stepConfig?.getSubStepConfiguration(currentSubStep);

      // Skip validation if configured
      if (!(subStepConfig?.skipValidation ??
          stepConfig?.skipValidation ??
          false)) {
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

      // Set loading state before exit callbacks
      emit(state.copyWith(isLoading: true, loadingDirection: direction));

      // Call custom exit if available
      if (subStepConfig?.customExit != null) {
        await subStepConfig!.customExit!(
          direction,
          currentStep,
          currentSubStep,
        );
      } else if (stepConfig?.customExit != null) {
        await stepConfig!.customExit!(direction, currentStep, currentSubStep);
      } else if (onScreenExit != null) {
        await onScreenExit!(direction, currentStep, currentSubStep);
      }

      // Clear loading state after exit callbacks
      emit(state.copyWith(isLoading: false, loadingDirection: null));

      // Check if we completed a step
      if (currentStep != newNextStep && onStepComplete != null) {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await onStepComplete!(currentStep);
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      }

      // Check if we completed the flow
      if (incrementNewSubStep == totalSubSteps && onFlowComplete != null) {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await onFlowComplete!();
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      }

      // Call custom enter if available
      final nextStepConfig = stepConfigurations[newNextStep];
      final nextSubStepConfig = nextStepConfig?.getSubStepConfiguration(
        incrementNewSubStep,
      );

      if (nextSubStepConfig?.customEnter != null) {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await nextSubStepConfig!.customEnter!(
          direction,
          newNextStep,
          incrementNewSubStep,
        );
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      } else if (nextStepConfig?.customEnter != null) {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await nextStepConfig!.customEnter!(
          direction,
          newNextStep,
          incrementNewSubStep,
        );
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      } else {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await onScreenEnterProcess(newNextStep, incrementNewSubStep);
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      }

      // Update state after all enter callbacks complete
      onSubStepChanged?.call(currentStep, incrementNewSubStep);
      emit(
        StepsFlowState(
          currentStep: newNextStep,
          currentSubStep: incrementNewSubStep,
        ),
      );
    } else if (direction == NavigationDirectionV2.backward) {
      // Get step configuration if available
      final stepConfig = stepConfigurations[currentStep];
      final subStepConfig = stepConfig?.getSubStepConfiguration(currentSubStep);

      // Skip validation if configured
      if (!(subStepConfig?.skipValidation ??
          stepConfig?.skipValidation ??
          false)) {
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

      // Set loading state before exit callbacks
      emit(state.copyWith(isLoading: true, loadingDirection: direction));

      // Call custom exit if available
      if (subStepConfig?.customExit != null) {
        await subStepConfig!.customExit!(
          direction,
          currentStep,
          currentSubStep,
        );
      } else if (stepConfig?.customExit != null) {
        await stepConfig!.customExit!(direction, currentStep, currentSubStep);
      } else if (onScreenExit != null) {
        await onScreenExit!(direction, currentStep, currentSubStep);
      }

      // Clear loading state after exit callbacks
      emit(state.copyWith(isLoading: false, loadingDirection: null));

      // Call custom enter if available
      final backStepConfig = stepConfigurations[newBackStep];
      final backSubStepConfig = backStepConfig?.getSubStepConfiguration(
        decrementNewSubStep,
      );

      if (backSubStepConfig?.customEnter != null) {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await backSubStepConfig!.customEnter!(
          direction,
          newBackStep,
          decrementNewSubStep,
        );
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      } else if (backStepConfig?.customEnter != null) {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await backStepConfig!.customEnter!(
          direction,
          newBackStep,
          decrementNewSubStep,
        );
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      } else {
        emit(state.copyWith(isLoading: true, loadingDirection: direction));
        await onScreenEnterProcess(newBackStep, decrementNewSubStep);
        emit(state.copyWith(isLoading: false, loadingDirection: null));
      }

      // Update state after all enter callbacks complete
      onSubStepChanged?.call(currentStep, decrementNewSubStep);
      emit(
        StepsFlowState(
          currentStep: newBackStep,
          currentSubStep: decrementNewSubStep,
        ),
      );
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
        state.loadingDirection ?? NavigationDirectionV2.forward,
        stepIndex,
        subStepIndex,
      );
    }
  }
}
