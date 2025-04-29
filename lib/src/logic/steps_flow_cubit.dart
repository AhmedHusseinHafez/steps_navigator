import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'steps_flow_cubit.freezed.dart';
part 'steps_flow_state.dart';

class StepsFlowCubit extends Cubit<StepsFlowState> {
  StepsFlowCubit({
    required this.totalSubSteps,
    required this.subStepsPerStep,
    this.onSubStepChanged,
    this.onNextValidation,
    this.onBackValidation,
    int initialSubStep = 1, // <- default to 1
  }) : super(
         StepsFlowState(
           currentStep: _determineStepFromInitial(
             initialSubStep,
             subStepsPerStep,
           ),
           currentSubStep: initialSubStep,
         ),
       );

  final int totalSubSteps;
  final List<int> subStepsPerStep;
  final void Function(int step, int subStep)? onSubStepChanged;
  final Future<bool> Function(int currentStep, int currentSubStep)?
  onNextValidation;
  final Future<bool> Function(int step, int subStep)? onBackValidation;

  Future<void> onNextPressed() async {
    final currentStep = state.currentStep;
    final currentSubStep = state.currentSubStep;

    // Check if validation exists and run it
    if (onNextValidation != null) {
      final isValid = await onNextValidation!(currentStep, currentSubStep);
      if (!isValid) return;
    }

    final newSubStep = (currentSubStep + 1).clamp(1, totalSubSteps);
    final newStep = _determineStep(newSubStep);

    emit(StepsFlowState(currentStep: newStep, currentSubStep: newSubStep));
    onSubStepChanged?.call(newStep, newSubStep); // Trigger callback
  }

  void onBackPressed() async {
    final currentStep = state.currentStep;
    final currentSubStep = state.currentSubStep;
    if (currentSubStep == 1) return;

    if (onBackValidation != null) {
      final isValid = await onBackValidation!(currentStep, currentSubStep);
      if (!isValid) return;
    }

    final newSubStep = (currentSubStep - 1).clamp(1, totalSubSteps);
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

  static int _determineStepFromInitial(int subStep, List<int> subStepsPerStep) {
    int cumulativeSubSteps = 0;
    for (int i = 0; i < subStepsPerStep.length; i++) {
      cumulativeSubSteps += subStepsPerStep[i];
      if (subStep <= cumulativeSubSteps) {
        return i + 1;
      }
    }
    return subStepsPerStep.length;
  }
}
