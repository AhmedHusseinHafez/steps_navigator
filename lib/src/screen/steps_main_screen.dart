import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_navigator/src/helper/steps_navigator_validator.dart';
import 'package:steps_navigator/src/logic/steps_flow_cubit.dart';
import 'package:steps_navigator/src/widgets/steps_nav_bar.dart';
import 'package:steps_navigator/steps_navigator.dart';

class StepsNavigator extends StatefulWidget {
  StepsNavigator({
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
  }) {
    StepsNavigatorValidator.validate(
      screens: screens,
      // totalSteps: totalSteps,
      subStepsPerStepPattern: subStepsPerStepPattern,
      initialPage: initialPage ?? 0,
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
  // final int totalSteps;

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

  final List<int> subStepsPerStepPattern;
  final void Function(int step, int subStep)? onSubStepChanged;
  final Future<bool> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )?
  onValidate;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? onScreenEnter;
  final Future<void> Function(
    NavigationDirection direction,
    int step,
    int subStep,
  )? onScreenExit;
  final Future<void> Function(int step)? onStepComplete;
  final Future<void> Function()? onFlowComplete;
  @override
  State<StepsNavigator> createState() => _StepsNavigatorState();
}

class _StepsNavigatorState extends State<StepsNavigator> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => StepsFlowCubit(
            onScreenEnter: widget.onScreenEnter,
            onScreenExit: widget.onScreenExit,
            onStepComplete: widget.onStepComplete,
            onFlowComplete: widget.onFlowComplete,
            subStepsPerStepPattern: widget.subStepsPerStepPattern,
            onSubStepChanged: widget.onSubStepChanged,
            onValidate: widget.onValidate,
            initialSubStep: (widget.initialPage ?? 0) + 1,
          ),
      child: Scaffold(
        appBar: widget.appBar,
        body: _bodyBloc(),
        bottomNavigationBar: SafeArea(
          child: SizedBox(
            height: kBottomNavigationBarHeight * 1.33,
            child: _buildStepsNavBar(),
          ),
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
        final cubit = context.read<StepsFlowCubit>();
        return StepsNavBar(
          subStepsPerStep: widget.subStepsPerStepPattern,
          currentStep: state.currentStep,
          currentSubStep: state.currentSubStep,
          state: state,
          onBackPressed:
              () => cubit.onProcess(
                NavigationDirection.backward,
                state.currentStep,
                state.currentSubStep,
              ),
          onNextPressed:
              () => cubit.onProcess(
                NavigationDirection.forward,
                state.currentStep,
                state.currentSubStep,
              ),
          customBackButton: widget.customBackButton,
          customNextButton: widget.customNextButton,
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

    super.dispose();
  }
}
