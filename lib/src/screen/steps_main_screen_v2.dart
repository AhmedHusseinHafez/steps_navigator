import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:steps_navigator_v2/src/helper/steps_navigator_validator.dart';
import 'package:steps_navigator_v2/src/logic/steps_flow_cubit.dart';
import 'package:steps_navigator_v2/src/widgets/steps_nav_bar.dart';
import 'package:steps_navigator_v2/steps_navigator_v2.dart';

class StepsNavigatorV2 extends StatelessWidget {
  StepsNavigatorV2({
    super.key,
    this.appBar,
    required this.screens,
    this.stepColor,
    this.progressColor,
    this.progressCurve,
    this.progressMoveDuration,
    this.stepHeight,
    this.spacing,
    this.padding,
    this.customBackButton,
    this.customNextButton,
    this.spaceBetweenButtonAndSteps,
    this.pageAnimationDuration,
    this.pageAnimationCurve,
    required this.subStepsPerStepPattern,
    this.onSubStepChanged,
    this.onValidate,
    this.onScreenEnter,
    this.onScreenExit,
    this.onStepComplete,
    this.onFlowComplete,
    this.initialPage = 0,
    this.debounceDuration,
    this.stepConfigurations = const {},
    this.navHeight,
  }) {
    StepsNavigatorValidator.validate(
      screens: screens,
      subStepsPerStepPattern: subStepsPerStepPattern,
      initialPage: initialPage ?? 0,
      stepConfigurations: stepConfigurations,
    );
  }

  final PreferredSizeWidget? appBar;
  final List<
    Widget Function(
      StepsFlowState state,
      void Function({bool? isNextEnabled, bool? isBackEnabled})
      updateButtonStates,
    )
  >
  screens;
  final Color? stepColor;
  final Color? progressColor;
  final Curve? progressCurve;
  final Duration? progressMoveDuration;
  final double? stepHeight;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final Widget? customBackButton;
  final Widget? customNextButton;
  final double? spaceBetweenButtonAndSteps;
  final Duration? pageAnimationDuration;
  final Curve? pageAnimationCurve;
  final int? initialPage;
  final Duration? debounceDuration;
  final List<int> subStepsPerStepPattern;
  final void Function(int step, int subStep)? onSubStepChanged;
  final Future<bool> Function(
    NavigationDirectionV2 direction,
    int step,
    int subStep,
  )?
  onValidate;
  final Future<void> Function(
    NavigationDirectionV2 direction,
    int step,
    int subStep,
  )?
  onScreenEnter;
  final Future<void> Function(
    NavigationDirectionV2 direction,
    int step,
    int subStep,
  )?
  onScreenExit;
  final Future<void> Function(int step)? onStepComplete;
  final Future<void> Function()? onFlowComplete;
  final Map<int, StepConfiguration> stepConfigurations;
  final double? navHeight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => StepsFlowCubit(
            onScreenEnter: onScreenEnter,
            onScreenExit: onScreenExit,
            onStepComplete: onStepComplete,
            onFlowComplete: onFlowComplete,
            subStepsPerStepPattern: subStepsPerStepPattern,
            onSubStepChanged: onSubStepChanged,
            onValidate: onValidate,
            initialSubStep: (initialPage ?? 0) + 1,
            stepConfigurations: stepConfigurations,
          ),
      child: _StepsNavigatorContent(
        appBar: appBar,
        screens: screens,
        stepColor: stepColor,
        progressColor: progressColor,
        progressCurve: progressCurve,
        progressMoveDuration: progressMoveDuration,
        stepHeight: stepHeight,
        spacing: spacing,
        padding: padding,
        customBackButton: customBackButton,
        customNextButton: customNextButton,
        spaceBetweenButtonAndSteps: spaceBetweenButtonAndSteps,
        pageAnimationDuration: pageAnimationDuration,
        pageAnimationCurve: pageAnimationCurve,
        initialPage: initialPage,
        debounceDuration: debounceDuration,
        stepConfigurations: stepConfigurations,
        subStepsPerStepPattern: subStepsPerStepPattern,
        navHeight: navHeight,
      ),
    );
  }
}

class _StepsNavigatorContent extends StatefulWidget {
  const _StepsNavigatorContent({
    required this.screens,
    required this.stepConfigurations,
    required this.subStepsPerStepPattern,
    this.appBar,
    this.stepColor,
    this.progressColor,
    this.progressCurve,
    this.progressMoveDuration,
    this.stepHeight,
    this.spacing,
    this.padding,
    this.customBackButton,
    this.customNextButton,
    this.spaceBetweenButtonAndSteps,
    this.pageAnimationDuration,
    this.pageAnimationCurve,
    this.initialPage,
    this.navHeight,
    this.debounceDuration,
  });

  final PreferredSizeWidget? appBar;
  final List<
    Widget Function(
      StepsFlowState state,
      void Function({bool? isNextEnabled, bool? isBackEnabled})
      updateButtonStates,
    )
  >
  screens;
  final Color? stepColor;
  final Color? progressColor;
  final Curve? progressCurve;
  final Duration? progressMoveDuration;
  final double? stepHeight;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final Widget? customBackButton;
  final Widget? customNextButton;
  final double? spaceBetweenButtonAndSteps;
  final Duration? pageAnimationDuration;
  final Curve? pageAnimationCurve;
  final int? initialPage;
  final Duration? debounceDuration;
  final List<int> subStepsPerStepPattern;
  final Map<int, StepConfiguration> stepConfigurations;
  final double? navHeight;

  @override
  State<_StepsNavigatorContent> createState() => _StepsNavigatorContentState();
}

class _StepsNavigatorContentState extends State<_StepsNavigatorContent> {
  late final PageController _pageController;
  final _navigationSubject = BehaviorSubject<NavigationDirectionV2>();
  late Duration _debounceDuration;

  @override
  void initState() {
    super.initState();
    _debounceDuration = widget.debounceDuration ?? Duration(milliseconds: 300);
    _pageController = PageController(initialPage: widget.initialPage ?? 0);
    _setupDebounce();
  }

  void _setupDebounce() {
    _navigationSubject.debounceTime(_debounceDuration).listen((
      direction,
    ) async {
      if (!mounted) return;
      final cubit = context.read<StepsFlowCubit>();
      final state = cubit.state;
      await cubit.onProcess(direction, state.currentStep, state.currentSubStep);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: _bodyBloc(),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: widget.navHeight ?? (kBottomNavigationBarHeight * 1.33),
          child: _buildStepsNavBar(),
        ),
      ),
    );
  }

  Widget _bodyBloc() {
    return BlocConsumer<StepsFlowCubit, StepsFlowState>(
      listenWhen:
          (previous, current) =>
              previous.currentSubStep != current.currentSubStep,
      listener: (context, state) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            state.currentSubStep - 1,
            duration:
                widget.pageAnimationDuration ??
                const Duration(milliseconds: 200),
            curve: widget.pageAnimationCurve ?? Curves.easeInOut,
          );
        }
      },
      builder: _body,
    );
  }

  Widget _body(BuildContext context, StepsFlowState state) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      itemCount: widget.screens.length,
      itemBuilder: (context, index) {
        return widget.screens[index](state, ({isNextEnabled, isBackEnabled}) {
          context.read<StepsFlowCubit>().updateButtonStates(
            isNextEnabled: isNextEnabled,
            isBackEnabled: isBackEnabled,
          );
        });
      },
    );
  }

  Widget _buildStepsNavBar() {
    return BlocBuilder<StepsFlowCubit, StepsFlowState>(
      builder: (context, state) {
        final currentStep = state.currentStep;
        final currentSubStep = state.currentSubStep;
        final stepConfig = widget.stepConfigurations[currentStep];
        final subStepConfig = stepConfig?.getSubStepConfiguration(
          currentSubStep,
        );

        return StepsNavBar(
          subStepsPerStep: widget.subStepsPerStepPattern,
          currentStep: state.currentStep,
          currentSubStep: state.currentSubStep,
          state: state,
          onBackPressed:
              !(subStepConfig?.disableBackButton ??
                      stepConfig?.disableBackButton ??
                      false)
                  ? () async {
                    _navigationSubject.add(NavigationDirectionV2.backward);
                    return;
                  }
                  : null,
          onNextPressed:
              !(subStepConfig?.disableNextButton ??
                      stepConfig?.disableNextButton ??
                      false)
                  ? () async {
                    _navigationSubject.add(NavigationDirectionV2.forward);
                    return;
                  }
                  : null,
          customBackButton:
              subStepConfig?.customBackButton ??
              stepConfig?.customBackButton ??
              widget.customBackButton,
          customNextButton:
              subStepConfig?.customNextButton ??
              stepConfig?.customNextButton ??
              widget.customNextButton,
          padding: widget.padding,
          progressColor: widget.progressColor,
          progressCurve: widget.progressCurve,
          progressMoveDuration: widget.progressMoveDuration,
          spacing: widget.spacing,
          stepColor: widget.stepColor,
          stepHeight: widget.stepHeight,
          spaceBetweenButtonAndSteps: widget.spaceBetweenButtonAndSteps,
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _navigationSubject.close();
    super.dispose();
  }
}
