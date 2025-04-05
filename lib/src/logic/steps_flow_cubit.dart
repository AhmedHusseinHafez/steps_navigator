import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'steps_flow_cubit.freezed.dart';
part 'steps_flow_state.dart';

class StepsFlowCubit extends Cubit<StepsFlowState> {
  StepsFlowCubit({
    required this.totalSubSteps,
    required this.subStepsPerStep,
    this.onSubStepChanged,
    this.onNextValidation, // New validation callback
  }) : super(const StepsFlowState(currentStep: 1, currentSubStep: 1));

  final int totalSubSteps;
  final List<int> subStepsPerStep;
  final void Function(int step, int subStep)? onSubStepChanged;
  final Future<bool> Function(int currentStep, int currentSubStep)?
  onNextValidation; // Async validation

  Future<void> onNextPressed() async {
    final currentStep = state.currentStep;
    final currentSubStep = state.currentSubStep;

    // Check if validation exists and run it
    if (onNextValidation != null) {
      final isValid = await onNextValidation!(currentStep, currentSubStep);
      if (!isValid) {
        return; // Don't proceed if validation fails
      }
    }

    final newSubStep = (currentSubStep + 1).clamp(1, totalSubSteps);
    final newStep = _determineStep(newSubStep);

    emit(StepsFlowState(currentStep: newStep, currentSubStep: newSubStep));
    onSubStepChanged?.call(newStep, newSubStep); // Trigger callback
  }

  void onBackPressed() {
    final newSubStep = (state.currentSubStep - 1).clamp(1, totalSubSteps);
    final newStep = _determineStep(newSubStep);

    emit(StepsFlowState(currentStep: newStep, currentSubStep: newSubStep));
    onSubStepChanged?.call(newStep, newSubStep);
  }

  int _determineStep(int subStep) {
    int cumulativeSubSteps = 0;
    for (int i = 0; i < subStepsPerStep.length; i++) {
      cumulativeSubSteps += subStepsPerStep[i];
      if (subStep <= cumulativeSubSteps) {
        return i + 1;
      }
    }
    return subStepsPerStep.length; // Fallback
  }
}
