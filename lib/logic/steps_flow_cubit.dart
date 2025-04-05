import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'steps_flow_cubit.freezed.dart';
part 'steps_flow_state.dart';

class StepsFlowCubit extends Cubit<StepsFlowState> {
  StepsFlowCubit({required this.totalSubSteps})
    : super(const StepsFlowState(currentStep: 1, currentSubStep: 1));

  final int totalSubSteps;

  // void onNextPressed() {
  //   final newSubStep = (state.currentSubStep + 1).clamp(1, totalSubSteps);
  //   final newStep = _determineStep(newSubStep);

  //   emit(StepsFlowState(currentStep: newStep, currentSubStep: newSubStep));
  // }

  void onNextPressed() {
    final int newSubStep = state.currentSubStep + 1;
    int newStep = state.currentStep;

    if (newSubStep > 4 && newSubStep <= 9) {
      newStep = 2;
    } else if (newSubStep > 9) {
      newStep = 3;
    }

    emit(
      StepsFlowState(
        currentStep: newStep,
        currentSubStep: newSubStep > 14 ? 14 : newSubStep,
      ),
    );
  }

  // void onBackPressed() {
  //   final newSubStep = (state.currentSubStep - 1).clamp(1, totalSubSteps);
  //   final newStep = _determineStep(newSubStep);

  //   emit(StepsFlowState(currentStep: newStep, currentSubStep: newSubStep));
  // }

  void onBackPressed() {
    int newSubStep = state.currentSubStep - 1;
    int newStep = state.currentStep;

    if (newSubStep <= 9 && newSubStep > 4) {
      newStep = 2;
    } else if (newSubStep <= 4) {
      newStep = 1;
    }

    emit(
      StepsFlowState(
        currentStep: newStep,
        currentSubStep: newSubStep < 1 ? 1 : newSubStep,
      ),
    );
  }

  int _determineStep(int subStep) {
    if (subStep <= 4) return 1;
    if (subStep <= 9) return 2;
    return 3;
  }
}
