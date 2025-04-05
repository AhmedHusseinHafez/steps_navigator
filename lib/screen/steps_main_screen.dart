import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_navigator/logic/steps_flow_cubit.dart';
import 'package:steps_navigator/widgets/steps_nav_bar.dart';

class StepsMainScreen extends StatefulWidget {
  const StepsMainScreen({
    super.key,
    this.appBar,
    required this.screens,
    required this.totalSteps,
  });
  final PreferredSizeWidget? appBar;
  final List<Widget> screens;
  final int totalSteps;

  @override
  State<StepsMainScreen> createState() => _StepsMainScreenState();
}

class _StepsMainScreenState extends State<StepsMainScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: _bodyBloc(),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: kBottomNavigationBarHeight * 1.33,
          child: _buildStepsNavBar(),
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
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
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
          totalSteps: widget.totalSteps,
          currentStep: state.currentStep,
          currentSubStep: state.currentSubStep,
          onBackPressed: cubit.onBackPressed,
          onNextPressed: cubit.onNextPressed,
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
