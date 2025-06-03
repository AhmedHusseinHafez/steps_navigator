import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'navigation_direction.dart';

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
  )?
  onValidate;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )?
  onScreenEnter;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? onScreenExit;
  final Future<void> Function(int step)? onStepComplete;
  final Future<void> Function()? onFlowComplete;

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

      if (onScreenExit != null) {
        await onScreenExit!(direction, currentStep, currentSubStep);
      }

      onSubStepChanged?.call(currentStep, incrementNewSubStep);
      emit(
        StepsFlowState(
          currentStep: newNextStep,
          currentSubStep: incrementNewSubStep,
        ),
      );

      if (currentStep != newNextStep && onStepComplete != null) {
        await onStepComplete!(currentStep);
      }

      if (incrementNewSubStep == totalSubSteps && onFlowComplete != null) {
        await onFlowComplete!();
      }

      await onScreenEnterProcess(newNextStep, incrementNewSubStep);
    } else if (direction == NavigationDirection.backward) {
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

      if (onScreenExit != null) {
        await onScreenExit!(direction, currentStep, currentSubStep);
      }

      onSubStepChanged?.call(currentStep, decrementNewSubStep);
      emit(
        StepsFlowState(
          currentStep: newBackStep,
          currentSubStep: decrementNewSubStep,
        ),
      );

      await onScreenEnterProcess(newBackStep, decrementNewSubStep);
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
