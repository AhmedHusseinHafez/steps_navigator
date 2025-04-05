import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_navigator/src/logic/steps_flow_cubit.dart';
import 'package:steps_navigator/src/widgets/steps_nav_bar.dart';

class StepsNavigator extends StatefulWidget {
  const StepsNavigator({
    super.key,
    this.appBar,
    required this.screens,
    required this.totalSteps,
    required this.totalSubSteps,
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
    required this.subStepsPerStep,
    this.onSubStepChanged,
    this.onNextValidation,
  });
  final PreferredSizeWidget? appBar;
  final List<Widget> screens;
  final int totalSteps;
  final int totalSubSteps;

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

  final List<int> subStepsPerStep;
  final void Function(int step, int subStep)? onSubStepChanged;
  final Future<bool> Function(int currentStep, int currentSubStep)?
  onNextValidation; // New parameter

  @override
  State<StepsNavigator> createState() => _StepsNavigatorState();
}

class _StepsNavigatorState extends State<StepsNavigator> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Validate inputs
    assert(widget.totalSteps == widget.subStepsPerStep.length);
    assert(
      widget.totalSubSteps == widget.subStepsPerStep.reduce((a, b) => a + b),
    );
    assert(widget.screens.length == widget.totalSubSteps);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => StepsFlowCubit(
            totalSubSteps: widget.totalSubSteps,
            subStepsPerStep: widget.subStepsPerStep,
            onSubStepChanged: widget.onSubStepChanged,
            onNextValidation: widget.onNextValidation,
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
    return BlocListener<StepsFlowCubit, StepsFlowState>(
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
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,

      itemCount: widget.screens.length,
      itemBuilder: (context, index) {
        return widget.screens[index];
      },
    );
  }

  Widget _buildStepsNavBar() {
    return BlocBuilder<StepsFlowCubit, StepsFlowState>(
      builder: (context, state) {
        final cubit = context.read<StepsFlowCubit>();
        return StepsNavBar(
          subStepsPerStep: widget.subStepsPerStep,
          totalSteps: widget.totalSteps,
          currentStep: state.currentStep,
          currentSubStep: state.currentSubStep,
          onBackPressed: cubit.onBackPressed,
          onNextPressed: cubit.onNextPressed,

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
