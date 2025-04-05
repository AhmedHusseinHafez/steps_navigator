// widgets/steps_main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/steps_flow_cubit.dart';

class StepsMainScreen extends StatefulWidget {
  final List<Widget> subStepScreens;
  final Widget Function()? overlayBuilder;
  final Widget Function(BuildContext context, StepsFlowState state)
  navBarBuilder;
  final PreferredSizeWidget? appBar;

  const StepsMainScreen({
    super.key,
    required this.subStepScreens,
    this.overlayBuilder,
    required this.navBarBuilder,
    this.appBar,
  });

  @override
  State<StepsMainScreen> createState() => _StepsMainScreenState();
}

class _StepsMainScreenState extends State<StepsMainScreen>
    with WidgetsBindingObserver {
  late final PageController _pageController;
  final ValueNotifier<double> _opacityNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addObserver(this);

    _pageController.addListener(() {
      if (_pageController.page?.round() == 1) {
        _opacityNotifier.value = 1;
      } else {
        _opacityNotifier.value = 0;
      }
    });
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
      listenWhen: (prev, curr) => prev.currentSubStep != curr.currentSubStep,
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: widget.subStepScreens.length,
          itemBuilder: (context, index) => widget.subStepScreens[index],
        ),
        if (widget.overlayBuilder != null)
          ValueListenableBuilder<double>(
            valueListenable: _opacityNotifier,
            builder: (context, opacity, child) {
              return IgnorePointer(
                ignoring: opacity == 0,
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(),
                  child: widget.overlayBuilder!(),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildStepsNavBar() {
    return BlocBuilder<StepsFlowCubit, StepsFlowState>(
      builder: (context, state) => widget.navBarBuilder(context, state),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
