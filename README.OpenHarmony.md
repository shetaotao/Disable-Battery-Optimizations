# disable_battery_optimization

This project is based on [disable_battery_optimization](https://github.com/pvsvamsi/Disable-Battery-Optimizations).

## Introduction

disable_battery_optimization is a Flutter plugin for checking battery optimization status and guiding users through related settings. This plugin supports querying app auto-start status and provides system settings navigation functionality.<br/>

## Installation

Navigate to your project directory and add the following dependency in `pubspec.yaml`:

```yaml
dependencies:
  disable_battery_optimization:
    git:
      url: https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization
      ref: 1.1.2-ohos-1.0.0
```

Run the command

```bash
flutter pub get
```

> TAG naming convention: `original-version-ohos-version-betax`. 

| Flutter Framework Version | TAG Name |
| ---------------- | ----------------------- |
| 3.7.12-ohos-1.1.3 | 1.1.2-ohos-1.0.0 |
| 3.22.1-ohos-1.1.0 | 1.1.2-ohos-1.0.0 |
| 3.27.5-ohos-1.0.4 | 1.1.2-ohos-1.0.0 |
| 3.35.8-ohos-0.0.2 | 1.1.2-ohos-1.0.0 |

## Constraints and Limitations

### Compatibility

Tested and verified on the following versions:

1. Flutter: 3.7.12-ohos-1.1.3; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6;
2. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6;
3. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6;
4. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6; 

### Permission Requirements

None

## Usage Example

disable_battery_optimization provides simple and easy-to-use APIs. The following snippet shows the simplest usage of this plugin:<br/>

```dart
import 'package:flutter/material.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Disable Battery Optimizations Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              // Check auto-start status
              MaterialButton(
                child: Text("Is Auto Start Enabled"),
                onPressed: () async {
                  bool isAutoStartEnabled =
                      await DisableBatteryOptimization.isAutoStartEnabled ?? false;
                  print("Auto start is ${isAutoStartEnabled ? "Enabled" : "Disabled"}");
                },
              ),
              // Check battery optimization status
              MaterialButton(
                child: Text("Is Battery optimization disabled"),
                onPressed: () async {
                  bool isBatteryOptimizationDisabled =
                      await DisableBatteryOptimization.isBatteryOptimizationDisabled ?? false;
                  print("Battery optimization is ${!isBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
                },
              ),
              // Check manufacturer battery optimization status
              MaterialButton(
                child: Text("Is Manufacturer Battery optimization disabled"),
                onPressed: () async {
                  bool isManBatteryOptimizationDisabled =
                      await DisableBatteryOptimization.isManufacturerBatteryOptimizationDisabled ?? false;
                  print("Manufacturer Battery optimization is ${!isManBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
                },
              ),
              // Check all optimization status
              MaterialButton(
                child: Text("Are All Battery optimizations disabled"),
                onPressed: () async {
                  bool isAllBatteryOptimizationDisabled =
                      await DisableBatteryOptimization.isAllBatteryOptimizationDisabled ?? false;
                  print("All Battery optimizations are disabled ${isAllBatteryOptimizationDisabled ? "True" : "False"}");
                },
              ),
              // Show auto-start settings
              MaterialButton(
                child: Text("Enable Auto Start"),
                onPressed: () {
                  DisableBatteryOptimization.showEnableAutoStartSettings(
                    "Enable Auto Start",
                    "Follow the steps and enable the auto start of this app",
                  );
                },
              ),
              // Show battery optimization settings
              MaterialButton(
                child: Text("Disable Battery Optimizations"),
                onPressed: () {
                  DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
                },
              ),
              // Show manufacturer battery optimization settings
              MaterialButton(
                child: Text("Disable Manufacturer Battery Optimizations"),
                onPressed: () {
                  DisableBatteryOptimization.showDisableManufacturerBatteryOptimizationSettings(
                    "Your device has additional battery optimization",
                    "Follow the steps and disable the optimizations to allow smooth functioning of this app",
                  );
                },
              ),
              // Show all optimization settings
              MaterialButton(
                child: Text("Disable all Optimizations"),
                onPressed: () {
                  DisableBatteryOptimization.showDisableAllOptimizationsSettings(
                    "Enable Auto Start",
                    "Follow the steps and enable the auto start of this app",
                    "Your device has additional battery optimization",
                    "Follow the steps and disable the optimizations to allow smooth functioning of this app",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Usage Instructions

### 1. Check Auto-Start Status

```dart
bool isAutoStartEnabled = await DisableBatteryOptimization.isAutoStartEnabled ?? false;
print("Auto start is ${isAutoStartEnabled ? "Enabled" : "Disabled"}");
```

### 2. Check Battery Optimization Status

```dart
bool isBatteryOptimizationDisabled = await DisableBatteryOptimization.isBatteryOptimizationDisabled ?? false;
print("Battery optimization is ${!isBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
```

### 3. Check Manufacturer Battery Optimization Status

```dart
bool isManBatteryOptimizationDisabled = await DisableBatteryOptimization.isManufacturerBatteryOptimizationDisabled ?? false;
print("Manufacturer Battery optimization is ${!isManBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
```

### 4. Check All Optimization Status

```dart
bool isAllBatteryOptimizationDisabled = await DisableBatteryOptimization.isAllBatteryOptimizationDisabled ?? false;
print("All Battery optimizations are disabled ${isAllBatteryOptimizationDisabled ? "True" : "False"}");
```

### 5. Show Auto-Start Settings

```dart
DisableBatteryOptimization.showEnableAutoStartSettings(
  "Enable Auto Start",
  "Follow the steps and enable the auto start of this app",
);
```

### 6. Show Battery Optimization Settings

```dart
DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
```

### 7. Show Manufacturer Battery Optimization Settings

```dart
DisableBatteryOptimization.showDisableManufacturerBatteryOptimizationSettings(
  "Your device has additional battery optimization",
  "Follow the steps and disable the optimizations to allow smooth functioning of this app",
);
```

### 8. Show All Optimization Settings

```dart
DisableBatteryOptimization.showDisableAllOptimizationsSettings(
  "Enable Auto Start",
  "Follow the steps and enable the auto start of this app",
  "Your device has additional battery optimization",
  "Follow the steps and disable the optimizations to allow smooth functioning of this app",
);
```

## API Reference

> [!TIP] In the "ohos Support" column: yes means the property is supported on the ohos platform, no means it is not supported. The usage method is consistent across platforms, with effects matching iOS or Android.

| Name | Type | Parameter Type | Return Value | OHOS Platform Support | Description |
|------|------|----------------|--------------|----------------------|-------------|
| showEnableAutoStartSettings() | method | `String dialogTitle, String dialogBody` | `Future<bool?>` | no | Shows auto-start guidance dialog and navigates to system settings |
| showDisableManufacturerBatteryOptimizationSettings() | method | `String dialogTitle, String dialogBody` | `Future<bool?>` | no | Shows manufacturer battery optimization guidance dialog and navigates to settings |
| showDisableBatteryOptimizationSettings() | method | none | `Future<bool?>` | no | Guides handling of system battery optimization settings |
| showDisableAllOptimizationsSettings() | method | `String autoStartTitle, String autoStartBody, String manBatteryTitle, String manBatteryBody` | `Future<bool?>` | no | One-shot guidance for auto-start, manufacturer battery, and system battery optimization |
| isAutoStartEnabled | property | none | `Future<bool?>` | yes | Queries current app auto-start status |
| isBatteryOptimizationDisabled | property | none | `Future<bool?>` | no | Checks whether the app is in the system ignore-battery-optimization whitelist |
| isManufacturerBatteryOptimizationDisabled | property | none | `Future<bool?>` | no | Checks whether user has disabled manufacturer power-saving/power-management restrictions |
| isAllBatteryOptimizationDisabled | property | none | `Future<bool?>` | no | Checks whether auto-start, manufacturer battery, and system battery optimization are all handled |

## Known Issues

None

## Others

None

## Directory Structure

```
|---- Directory
|     |---- android   # Android adaptation code
|     |---- example   # Complete example app for multiple platforms
|           |----lib  # Example code
|           |----ohos # OpenHarmony project
|     |---- lib       # Core code implementation
|           |---- disable_battery_optimization.dart  # Main entry file of the library
|     |---- ohos      # OpenHarmony adaptation code
|     |---- test      # Unit test files
|     |---- CHANGELOG.md              # Changelog
|     |---- LICENSE                   # License
|     |---- README.OpenHarmony_CN.md  # Chinese documentation
|     |---- README.OpenHarmony.md     # English documentation
|     |---- pubspec.yaml              # Configuration file
```

## Contributing

If you encounter any issues during use, please feel free to submit an [Issue](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization/issues). Of course, [PRs](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization/pulls) are also very welcome.

## License

This project is open-sourced under [The MIT License](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization/blob/master/LICENSE). Please feel free to enjoy and participate in open source.
