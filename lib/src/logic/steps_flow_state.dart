part of 'steps_flow_cubit.dart';

class StepsFlowState {
  final int currentStep;
  final int currentSubStep;
  final bool isLoading;
  final NavigationDirectionV2? loadingDirection;
  final bool isNextEnabled;
  final bool isBackEnabled;

  const StepsFlowState({
    required this.currentStep,
    required this.currentSubStep,
    this.isLoading = false,
    this.loadingDirection,
    this.isNextEnabled = true,
    this.isBackEnabled = true,
  });

  StepsFlowState copyWith({
    int? currentStep,
    int? currentSubStep,
    bool? isLoading,
    NavigationDirectionV2? loadingDirection,
    bool? isNextEnabled,
    bool? isBackEnabled,
  }) {
    return StepsFlowState(
      currentStep: currentStep ?? this.currentStep,
      currentSubStep: currentSubStep ?? this.currentSubStep,
      isLoading: isLoading ?? this.isLoading,
      loadingDirection: loadingDirection ?? this.loadingDirection,
      isNextEnabled: isNextEnabled ?? this.isNextEnabled,
      isBackEnabled: isBackEnabled ?? this.isBackEnabled,
    );
  }
}
