part of 'steps_flow_cubit.dart';

@freezed
abstract class StepsFlowState with _$StepsFlowState {
  const factory StepsFlowState({
    required int currentStep,
    required int currentSubStep,
    @Default(false) bool isLoading,
    NavigationDirection? loadingDirection,
    @Default(true) bool isNextEnabled,
    @Default(true) bool isBackEnabled,
  }) = _StepsFlowState;
}
