# Logging Best Practices for Steps Navigator

## Overview

The Steps Navigator package includes comprehensive logging capabilities that help with debugging and monitoring. However, excessive logging can impact performance and create noise in production environments.

## Current Logging Issues

The verbose logging you're experiencing comes from:

1. **BLoC Observer**: Logging every state change in `StepsFlowCubit`
2. **Custom Callbacks**: Logging in `onScreenEnter`, `onScreenExit`, etc.
3. **Button Press Events**: Logging every button interaction

## Solutions Implemented

### 1. Debug-Only Logging

All logging statements now use `kDebugMode` checks:

```dart
if (kDebugMode) {
  log('Your debug message here');
}
```

### 2. Smart BLoC Observer

The `MyBlocObserver` now:
- Only logs in debug mode
- Filters out frequent loading state changes
- Only logs significant state changes

### 3. Centralized Logger

Use the `StepsNavigatorLogger` for consistent logging:

```dart
import 'package:steps_navigator_v2/steps_navigator_v2.dart';

// Debug info (only in debug mode)
StepsNavigatorLogger.debug('Debug message');

// Info (only in debug mode)
StepsNavigatorLogger.info('Info message');

// Warnings (always logged)
StepsNavigatorLogger.warning('Warning message');

// Errors (always logged)
StepsNavigatorLogger.error('Error message');

// State changes (filtered)
StepsNavigatorLogger.stateChange('StepsFlowCubit', state);

// Navigation events
StepsNavigatorLogger.navigation('step_changed', {
  'from': previousStep,
  'to': currentStep,
  'direction': direction,
});
```

## Best Practices

### 1. Use Debug-Only Logging

```dart
// ✅ Good
if (kDebugMode) {
  log('Debug information');
}

// ❌ Bad
log('Debug information'); // Always logs
```

### 2. Filter State Changes

```dart
// ✅ Good - Only log significant changes
StepsNavigatorLogger.stateChange('StepsFlowCubit', state, isSignificant: true);

// ❌ Bad - Log every state change
log('State changed: $state');
```

### 3. Use Appropriate Log Levels

```dart
// Debug information
StepsNavigatorLogger.debug('User clicked next button');

// Important events
StepsNavigatorLogger.info('Step completed: $stepNumber');

// Issues that need attention
StepsNavigatorLogger.warning('Validation failed for step $stepNumber');

// Errors that need immediate attention
StepsNavigatorLogger.error('Failed to navigate to step $stepNumber', error);
```

### 4. Avoid Logging Sensitive Data

```dart
// ✅ Good
StepsNavigatorLogger.info('User completed step 1');

// ❌ Bad
StepsNavigatorLogger.info('User completed step 1 with data: $sensitiveData');
```

### 5. Use Structured Logging

```dart
// ✅ Good - Structured data
StepsNavigatorLogger.navigation('step_changed', {
  'from': previousStep,
  'to': currentStep,
  'direction': direction.toString(),
});

// ❌ Bad - Unstructured
log('Step changed from $previousStep to $currentStep');
```

## Configuration Options

### Disable All Logging

To completely disable logging in production:

```dart
// In your main.dart
void main() {
  if (kReleaseMode) {
    // Disable BLoC observer in release mode
    Bloc.observer = BlocObserver(); // Empty observer
  } else {
    Bloc.observer = MyBlocObserver();
  }
  runApp(MyApp());
}
```

### Custom Logging Levels

You can modify the `StepsNavigatorLogger` to support different log levels:

```dart
enum LogLevel { none, error, warning, info, debug }

class StepsNavigatorLogger {
  static LogLevel _level = kDebugMode ? LogLevel.debug : LogLevel.warning;
  
  static void setLogLevel(LogLevel level) {
    _level = level;
  }
  
  static void debug(String message) {
    if (_level.index >= LogLevel.debug.index) {
      // Log implementation
    }
  }
}
```

## Performance Impact

- **Debug Mode**: Minimal impact, logs are filtered
- **Release Mode**: No logging overhead
- **State Changes**: Reduced from ~10 logs per navigation to ~2 logs

## Migration Guide

If you're using the old logging approach:

```dart
// Old way
log('onScreenEnter: $direction, $step, $subStep');

// New way
if (kDebugMode) {
  StepsNavigatorLogger.navigation('screen_enter', {
    'direction': direction.toString(),
    'step': step,
    'subStep': subStep,
  });
}
```

This approach ensures your app remains performant while still providing useful debugging information when needed. 