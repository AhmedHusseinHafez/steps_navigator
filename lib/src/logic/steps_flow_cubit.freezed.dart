// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'steps_flow_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StepsFlowState {
  int get currentStep => throw _privateConstructorUsedError;
  int get currentSubStep => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  NavigationDirectionV2? get loadingDirection =>
      throw _privateConstructorUsedError;
  bool get isNextEnabled => throw _privateConstructorUsedError;
  bool get isBackEnabled => throw _privateConstructorUsedError;

  /// Create a copy of StepsFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StepsFlowStateCopyWith<StepsFlowState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepsFlowStateCopyWith<$Res> {
  factory $StepsFlowStateCopyWith(
    StepsFlowState value,
    $Res Function(StepsFlowState) then,
  ) = _$StepsFlowStateCopyWithImpl<$Res, StepsFlowState>;
  @useResult
  $Res call({
    int currentStep,
    int currentSubStep,
    bool isLoading,
    NavigationDirectionV2? loadingDirection,
    bool isNextEnabled,
    bool isBackEnabled,
  });
}

/// @nodoc
class _$StepsFlowStateCopyWithImpl<$Res, $Val extends StepsFlowState>
    implements $StepsFlowStateCopyWith<$Res> {
  _$StepsFlowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StepsFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? currentSubStep = null,
    Object? isLoading = null,
    Object? loadingDirection = freezed,
    Object? isNextEnabled = null,
    Object? isBackEnabled = null,
  }) {
    return _then(
      _value.copyWith(
            currentStep:
                null == currentStep
                    ? _value.currentStep
                    : currentStep // ignore: cast_nullable_to_non_nullable
                        as int,
            currentSubStep:
                null == currentSubStep
                    ? _value.currentSubStep
                    : currentSubStep // ignore: cast_nullable_to_non_nullable
                        as int,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            loadingDirection:
                freezed == loadingDirection
                    ? _value.loadingDirection
                    : loadingDirection // ignore: cast_nullable_to_non_nullable
                        as NavigationDirectionV2?,
            isNextEnabled:
                null == isNextEnabled
                    ? _value.isNextEnabled
                    : isNextEnabled // ignore: cast_nullable_to_non_nullable
                        as bool,
            isBackEnabled:
                null == isBackEnabled
                    ? _value.isBackEnabled
                    : isBackEnabled // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StepsFlowStateImplCopyWith<$Res>
    implements $StepsFlowStateCopyWith<$Res> {
  factory _$$StepsFlowStateImplCopyWith(
    _$StepsFlowStateImpl value,
    $Res Function(_$StepsFlowStateImpl) then,
  ) = __$$StepsFlowStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentStep,
    int currentSubStep,
    bool isLoading,
    NavigationDirectionV2? loadingDirection,
    bool isNextEnabled,
    bool isBackEnabled,
  });
}

/// @nodoc
class __$$StepsFlowStateImplCopyWithImpl<$Res>
    extends _$StepsFlowStateCopyWithImpl<$Res, _$StepsFlowStateImpl>
    implements _$$StepsFlowStateImplCopyWith<$Res> {
  __$$StepsFlowStateImplCopyWithImpl(
    _$StepsFlowStateImpl _value,
    $Res Function(_$StepsFlowStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StepsFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? currentSubStep = null,
    Object? isLoading = null,
    Object? loadingDirection = freezed,
    Object? isNextEnabled = null,
    Object? isBackEnabled = null,
  }) {
    return _then(
      _$StepsFlowStateImpl(
        currentStep:
            null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                    as int,
        currentSubStep:
            null == currentSubStep
                ? _value.currentSubStep
                : currentSubStep // ignore: cast_nullable_to_non_nullable
                    as int,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        loadingDirection:
            freezed == loadingDirection
                ? _value.loadingDirection
                : loadingDirection // ignore: cast_nullable_to_non_nullable
                    as NavigationDirectionV2?,
        isNextEnabled:
            null == isNextEnabled
                ? _value.isNextEnabled
                : isNextEnabled // ignore: cast_nullable_to_non_nullable
                    as bool,
        isBackEnabled:
            null == isBackEnabled
                ? _value.isBackEnabled
                : isBackEnabled // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$StepsFlowStateImpl implements _StepsFlowState {
  const _$StepsFlowStateImpl({
    required this.currentStep,
    required this.currentSubStep,
    this.isLoading = false,
    this.loadingDirection,
    this.isNextEnabled = true,
    this.isBackEnabled = true,
  });

  @override
  final int currentStep;
  @override
  final int currentSubStep;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final NavigationDirectionV2? loadingDirection;
  @override
  @JsonKey()
  final bool isNextEnabled;
  @override
  @JsonKey()
  final bool isBackEnabled;

  @override
  String toString() {
    return 'StepsFlowState(currentStep: $currentStep, currentSubStep: $currentSubStep, isLoading: $isLoading, loadingDirection: $loadingDirection, isNextEnabled: $isNextEnabled, isBackEnabled: $isBackEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepsFlowStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.currentSubStep, currentSubStep) ||
                other.currentSubStep == currentSubStep) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.loadingDirection, loadingDirection) ||
                other.loadingDirection == loadingDirection) &&
            (identical(other.isNextEnabled, isNextEnabled) ||
                other.isNextEnabled == isNextEnabled) &&
            (identical(other.isBackEnabled, isBackEnabled) ||
                other.isBackEnabled == isBackEnabled));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentStep,
    currentSubStep,
    isLoading,
    loadingDirection,
    isNextEnabled,
    isBackEnabled,
  );

  /// Create a copy of StepsFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StepsFlowStateImplCopyWith<_$StepsFlowStateImpl> get copyWith =>
      __$$StepsFlowStateImplCopyWithImpl<_$StepsFlowStateImpl>(
        this,
        _$identity,
      );
}

abstract class _StepsFlowState implements StepsFlowState {
  const factory _StepsFlowState({
    required final int currentStep,
    required final int currentSubStep,
    final bool isLoading,
    final NavigationDirectionV2? loadingDirection,
    final bool isNextEnabled,
    final bool isBackEnabled,
  }) = _$StepsFlowStateImpl;

  @override
  int get currentStep;
  @override
  int get currentSubStep;
  @override
  bool get isLoading;
  @override
  NavigationDirectionV2? get loadingDirection;
  @override
  bool get isNextEnabled;
  @override
  bool get isBackEnabled;

  /// Create a copy of StepsFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StepsFlowStateImplCopyWith<_$StepsFlowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
