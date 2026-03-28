# disable_battery_optimization

This project is based on [disable_battery_optimization](https://github.com/pvsvamsi/Disable-Battery-Optimizations), and provides battery-optimization status checks and system-settings guidance for OpenHarmony Flutter scenarios.

## 1. Installation and Usage

### 1.1 Installation

Add the dependency in `pubspec.yaml`:

#### pubspec.yaml

```yaml
dependencies:
  disable_battery_optimization:
    git:
      url: https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization
      ref: master
```

Run:

```bash
flutter pub get
```

### 1.2 Example

See [example](example/lib/main.dart) for a full demo.


## 2. Constraints

1. Flutter: 3.7.12-ohos-1.1.3; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
2. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
3. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
4. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;

## 3. Version and Framework Mapping

| Version | 3.7 | 3.22 | 3.27 | 3.35 |
| --- | --- | --- | --- | --- |
| 1.0.0 | ✅ | ✅ | ✅ | ✅ |

## 4. API

> [!TIP] In the "ohos Support" column: yes = supported; no = unsupported; partially = partially supported.

| Name | Description | Type | Input | Output | ohos Support |
| --- | --- | --- | --- | --- | --- |
| showEnableAutoStart | Shows an auto-start guidance dialog and jumps to system settings | function | `title: string, message: string` | bool | no |
| showDisableManBatteryOptimization | Shows vendor battery-optimization guidance and jumps to settings | function | `title: string, message: string` | bool | no |
| showDisableBatteryOptimization | Guides handling of system battery optimization settings | function | none | bool | no |
| disableAllOptimizations | One-shot flow for auto-start, vendor battery optimization, and system battery optimization | function | `autoStartTitle, autoStartMessage, manBatteryTitle, manBatteryMessage` | bool | no |
| isAutoStartEnabled | Checks current app auto-start status | function | none | bool | yes |
| isBatteryOptimizationDisabled | Checks whether the app is in the system ignore-battery-optimization whitelist | function | none | bool | no |
| isManBatteryOptimizationDisabled | Checks whether vendor power-management restriction has been handled | function | none | bool | no |
| isAllOptimizationsDisabled | Checks whether auto-start, vendor battery optimization, and system battery optimization are all handled | function | none | bool | no |

## 5. License

This project is open-sourced under [MIT](LICENSE).
