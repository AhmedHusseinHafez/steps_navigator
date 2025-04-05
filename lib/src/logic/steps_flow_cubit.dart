import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'steps_flow_cubit.freezed.dart';
part 'steps_flow_state.dart';

class StepsFlowCubit extends Cubit<StepsFlowState> {
  StepsFlowCubit({
    required this.totalSubSteps,
    required this.subStepsPerStep,
    this.onSubStepChanged,
  }) : super(const StepsFlowState(currentStep: 1, currentSubStep: 1));

  final int totalSubSteps;
  final List<int> subStepsPerStep;
  final void Function(int step, int subStep)? onSubStepChanged;

  void onNextPressed() {
    final newSubStep = (state.currentSubStep + 1).clamp(1, totalSubSteps);
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
