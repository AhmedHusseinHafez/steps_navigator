import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'steps_flow_cubit.freezed.dart';
part 'steps_flow_state.dart';

class StepsFlowCubit extends Cubit<StepsFlowState> {
  StepsFlowCubit({required this.totalSubSteps, required this.subStepsPerStep})
    : super(const StepsFlowState(currentStep: 1, currentSubStep: 1));

  final int totalSubSteps;
  final List<int> subStepsPerStep;

  void onNextPressed() {
    final newSubStep = (state.currentSubStep + 1).clamp(1, totalSubSteps);
    final newStep = _determineStep(newSubStep);

    emit(StepsFlowState(currentStep: newStep, currentSubStep: newSubStep));
  }

  void onBackPressed() {
    final newSubStep = (state.currentSubStep - 1).clamp(1, totalSubSteps);
    final newStep = _determineStep(newSubStep);

    emit(StepsFlowState(currentStep: newStep, currentSubStep: newSubStep));
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
