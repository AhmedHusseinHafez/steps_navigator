# Steps Navigator

A powerful and flexible Flutter package for creating multi-step navigation flows with support for sub-steps, validation, and custom configurations.

## Features

- 🎯 **Multi-step Navigation**: Create complex step-by-step flows with main steps and sub-steps
- 🔄 **Validation Support**: Validate steps before proceeding with customizable validation logic
- ⚡ **Loading States**: Built-in loading indicators during validation and navigation
- 🎨 **Customizable UI**: Customize step indicators, buttons, and animations
- 🔌 **Lifecycle Hooks**: Access step lifecycle events (enter, exit, complete)
- 🛠️ **Per-step Configuration**: Configure individual steps and sub-steps with specific behaviors
- ⏱️ **Debounced Navigation**: Prevent rapid navigation with configurable debounce duration

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  steps_navigator: ^3.0.0
```

## Usage

### Basic Example

```dart
StepsNavigator(
  screens: [
    (state, updateButtonStates) => Step1Screen(),
    (state, updateButtonStates) => Step2Screen(),
    (state, updateButtonStates) => Step3Screen(),
  ],
  subStepsPerStepPattern: [1, 1, 1], // One sub-step per main step
  onValidate: (direction, step, subStep) async {
    // Your validation logic here
    return true;
  },
)
```

### Advanced Example with Sub-steps

```dart
StepsNavigator(
  screens: [
    // Step 1 with 2 sub-steps
    (state, updateButtonStates) => Step1SubStep1Screen(),
    (state, updateButtonStates) => Step1SubStep2Screen(),
    // Step 2 with 3 sub-steps
    (state, updateButtonStates) => Step2SubStep1Screen(),
    (state, updateButtonStates) => Step2SubStep2Screen(),
    (state, updateButtonStates) => Step2SubStep3Screen(),
  ],
  subStepsPerStepPattern: [2, 3], // 2 sub-steps in first step, 3 in second
  onValidate: (direction, step, subStep) async {
    // Your validation logic here
    return true;
  },
  onScreenEnter: (direction, step, subStep) async {
    // Handle screen enter
  },
  onScreenExit: (direction, step, subStep) async {
    // Handle screen exit
  },
  onStepComplete: (step) async {
    // Handle step completion
  },
  onFlowComplete: () async {
    // Handle flow completion
  },
)
```

### Custom Configuration

```dart
StepsNavigator(
  // ... other properties ...
  stepConfigurations: {
    1: StepConfiguration(
      skipValidation: true,
      customBackButton: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      subStepConfigurations: {
        2: SubStepConfiguration(
          disableNextButton: true,
          customNextButton: ElevatedButton(
            child: Text('Custom Next'),
            onPressed: () {},
          ),
        ),
      },
    ),
  },
)
```

## API Reference

### StepsNavigator

The main widget that handles the step navigation flow.

#### Required Properties

- `screens`: List of screen builders that return widgets for each step
- `subStepsPerStepPattern`: List of integers defining how many sub-steps each main step has

#### Optional Properties

- `appBar`: Custom app bar widget
- `stepColor`: Color for step indicators
- `progressColor`: Color for progress bar
- `progressCurve`: Animation curve for progress bar
- `progressMoveDuration`: Duration for progress bar animation
- `stepHeight`: Height of step indicators
- `spacing`: Spacing between step indicators
- `padding`: Padding around the navigation bar
- `customBackButton`: Custom back button widget
- `customNextButton`: Custom next button widget
- `spaceBetweenButtonAndSteps`: Space between buttons and step indicators
- `pageAnimationDuration`: Duration for page transitions
- `pageAnimationCurve`: Animation curve for page transitions
- `initialPage`: Initial page index (default: 0)
- `debounceDuration`: Duration to debounce navigation (default: 300ms)
- `stepConfigurations`: Map of step-specific configurations

#### Callbacks

- `onSubStepChanged`: Called when sub-step changes
- `onValidate`: Called before navigation to validate the current step
- `onScreenEnter`: Called when entering a screen
- `onScreenExit`: Called when exiting a screen
- `onStepComplete`: Called when a main step is completed
- `onFlowComplete`: Called when the entire flow is completed

### StepConfiguration

Configuration for individual steps.

#### Properties

- `skipValidation`: Skip validation for this step
- `disableBackButton`: Disable back button for this step
- `disableNextButton`: Disable next button for this step
- `customBackButton`: Custom back button for this step
- `customNextButton`: Custom next button for this step
- `customEnter`: Custom enter callback for this step
- `customExit`: Custom exit callback for this step
- `subStepConfigurations`: Map of sub-step configurations

### SubStepConfiguration

Configuration for individual sub-steps.

#### Properties

- `skipValidation`: Skip validation for this sub-step
- `disableBackButton`: Disable back button for this sub-step
- `disableNextButton`: Disable next button for this sub-step
- `customBackButton`: Custom back button for this sub-step
- `customNextButton`: Custom next button for this sub-step
- `customEnter`: Custom enter callback for this sub-step
- `customExit`: Custom exit callback for this sub-step

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
