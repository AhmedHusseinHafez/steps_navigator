// logic/steps_flow_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'steps_flow_cubit.freezed.dart';
part 'steps_flow_state.dart';

class StepsFlowCubit extends Cubit<StepsFlowState> {
  StepsFlowCubit({required this.totalSubSteps})
    : super(const StepsFlowState(currentStep: 1, currentSubStep: 1));

  final int totalSubSteps;

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
    if (subStep <= 4) return 1;
    if (subStep <= 9) return 2;
    return 3;
  }
}
