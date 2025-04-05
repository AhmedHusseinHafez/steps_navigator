part of 'steps_flow_cubit.dart';

@freezed
sealed class StepsFlowState with _$StepsFlowState {
  const factory StepsFlowState({
    required int currentStep,
    required int currentSubStep,
  }) = _StepsFlowState;
}
