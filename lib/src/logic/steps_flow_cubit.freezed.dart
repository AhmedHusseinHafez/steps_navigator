// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'steps_flow_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StepsFlowState {

 int get currentStep; int get currentSubStep; bool get isLoading; NavigationDirection? get loadingDirection; bool get isNextEnabled; bool get isBackEnabled;
/// Create a copy of StepsFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepsFlowStateCopyWith<StepsFlowState> get copyWith => _$StepsFlowStateCopyWithImpl<StepsFlowState>(this as StepsFlowState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepsFlowState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.currentSubStep, currentSubStep) || other.currentSubStep == currentSubStep)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadingDirection, loadingDirection) || other.loadingDirection == loadingDirection)&&(identical(other.isNextEnabled, isNextEnabled) || other.isNextEnabled == isNextEnabled)&&(identical(other.isBackEnabled, isBackEnabled) || other.isBackEnabled == isBackEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,currentSubStep,isLoading,loadingDirection,isNextEnabled,isBackEnabled);

@override
String toString() {
  return 'StepsFlowState(currentStep: $currentStep, currentSubStep: $currentSubStep, isLoading: $isLoading, loadingDirection: $loadingDirection, isNextEnabled: $isNextEnabled, isBackEnabled: $isBackEnabled)';
}


}

/// @nodoc
abstract mixin class $StepsFlowStateCopyWith<$Res>  {
  factory $StepsFlowStateCopyWith(StepsFlowState value, $Res Function(StepsFlowState) _then) = _$StepsFlowStateCopyWithImpl;
@useResult
$Res call({
 int currentStep, int currentSubStep, bool isLoading, NavigationDirection? loadingDirection, bool isNextEnabled, bool isBackEnabled
});




}
/// @nodoc
class _$StepsFlowStateCopyWithImpl<$Res>
    implements $StepsFlowStateCopyWith<$Res> {
  _$StepsFlowStateCopyWithImpl(this._self, this._then);

  final StepsFlowState _self;
  final $Res Function(StepsFlowState) _then;

/// Create a copy of StepsFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? currentSubStep = null,Object? isLoading = null,Object? loadingDirection = freezed,Object? isNextEnabled = null,Object? isBackEnabled = null,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,currentSubStep: null == currentSubStep ? _self.currentSubStep : currentSubStep // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingDirection: freezed == loadingDirection ? _self.loadingDirection : loadingDirection // ignore: cast_nullable_to_non_nullable
as NavigationDirection?,isNextEnabled: null == isNextEnabled ? _self.isNextEnabled : isNextEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBackEnabled: null == isBackEnabled ? _self.isBackEnabled : isBackEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _StepsFlowState implements StepsFlowState {
  const _StepsFlowState({required this.currentStep, required this.currentSubStep, this.isLoading = false, this.loadingDirection, this.isNextEnabled = true, this.isBackEnabled = true});
  

@override final  int currentStep;
@override final  int currentSubStep;
@override@JsonKey() final  bool isLoading;
@override final  NavigationDirection? loadingDirection;
@override@JsonKey() final  bool isNextEnabled;
@override@JsonKey() final  bool isBackEnabled;

/// Create a copy of StepsFlowState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepsFlowStateCopyWith<_StepsFlowState> get copyWith => __$StepsFlowStateCopyWithImpl<_StepsFlowState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepsFlowState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.currentSubStep, currentSubStep) || other.currentSubStep == currentSubStep)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loadingDirection, loadingDirection) || other.loadingDirection == loadingDirection)&&(identical(other.isNextEnabled, isNextEnabled) || other.isNextEnabled == isNextEnabled)&&(identical(other.isBackEnabled, isBackEnabled) || other.isBackEnabled == isBackEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep,currentSubStep,isLoading,loadingDirection,isNextEnabled,isBackEnabled);

@override
String toString() {
  return 'StepsFlowState(currentStep: $currentStep, currentSubStep: $currentSubStep, isLoading: $isLoading, loadingDirection: $loadingDirection, isNextEnabled: $isNextEnabled, isBackEnabled: $isBackEnabled)';
}


}

/// @nodoc
abstract mixin class _$StepsFlowStateCopyWith<$Res> implements $StepsFlowStateCopyWith<$Res> {
  factory _$StepsFlowStateCopyWith(_StepsFlowState value, $Res Function(_StepsFlowState) _then) = __$StepsFlowStateCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, int currentSubStep, bool isLoading, NavigationDirection? loadingDirection, bool isNextEnabled, bool isBackEnabled
});




}
/// @nodoc
class __$StepsFlowStateCopyWithImpl<$Res>
    implements _$StepsFlowStateCopyWith<$Res> {
  __$StepsFlowStateCopyWithImpl(this._self, this._then);

  final _StepsFlowState _self;
  final $Res Function(_StepsFlowState) _then;

/// Create a copy of StepsFlowState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? currentSubStep = null,Object? isLoading = null,Object? loadingDirection = freezed,Object? isNextEnabled = null,Object? isBackEnabled = null,}) {
  return _then(_StepsFlowState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,currentSubStep: null == currentSubStep ? _self.currentSubStep : currentSubStep // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingDirection: freezed == loadingDirection ? _self.loadingDirection : loadingDirection // ignore: cast_nullable_to_non_nullable
as NavigationDirection?,isNextEnabled: null == isNextEnabled ? _self.isNextEnabled : isNextEnabled // ignore: cast_nullable_to_non_nullable
as bool,isBackEnabled: null == isBackEnabled ? _self.isBackEnabled : isBackEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
