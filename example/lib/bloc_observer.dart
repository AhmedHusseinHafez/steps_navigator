import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    // Only log in debug mode
    if (kDebugMode) {
      // Filter out frequent state changes to reduce noise
      // You can customize this filtering based on your needs
      if (bloc.runtimeType.toString().contains('StepsFlowCubit')) {
        // Only log significant state changes, not loading state toggles
        final currentState = change.currentState;
        final nextState = change.nextState;

        // Skip logging if only loading state changed
        if (currentState.toString().contains('isLoading: false') &&
            nextState.toString().contains('isLoading: true')) {
          return;
        }
        if (currentState.toString().contains('isLoading: true') &&
            nextState.toString().contains('isLoading: false')) {
          return;
        }

        // Log only meaningful state changes
        log('${bloc.runtimeType} State Change: ${change.nextState}');
      } else {
        // For other BLoCs, log normally
        log('${bloc.runtimeType} $change');
      }
    }
  }
}
