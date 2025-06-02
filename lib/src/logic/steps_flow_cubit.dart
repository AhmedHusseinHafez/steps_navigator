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
    int initialSubStep = 1, // <- default to 1
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
      onSubStepChanged?.call(currentStep, incrementNewSubStep);
      emit(
        StepsFlowState(
          currentStep: newNextStep,
          currentSubStep: incrementNewSubStep,
        ),
      );
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

  void updateButtonStates({
    bool? isNextEnabled,
    bool? isBackEnabled,
  }) {
    emit(state.copyWith(
      isNextEnabled: isNextEnabled ?? state.isNextEnabled,
      isBackEnabled: isBackEnabled ?? state.isBackEnabled,
    ));
  }
}
