# `disable_battery_optimization`

本项目基于 [disable_battery_optimization](https://github.com/pvsvamsi/Disable-Battery-Optimizations) 开发，为 OpenHarmony Flutter 场景提供电池优化状态查询与系统设置引导能力。

## 1. 安装与使用

### 1.1 安装方式

进入到工程目录并在 `pubspec.yaml` 中添加以下依赖：

<!-- tabs:start -->

#### pubspec.yaml

```yaml
dependencies:
  disable_battery_optimization:
    git:
      url: https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization
      ref: master
```

执行命令

```bash
flutter pub get
```

<!-- tabs:end -->

### 1.2 使用案例

使用案例详见 [example](example/lib/main.dart)。


## 2. 约束与限制

### 2.1 兼容性

在以下版本中已测试通过：

1. Flutter: 3.7.12-ohos-1.1.3; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
2. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
3. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;
4. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.0.2.640; ROM: 6.0.0.130 SP18;

## 3. 版本和框架对应关系

| Version | 3.7 | 3.22 | 3.27 | 3.35 |
| --- | --- | --- | --- | --- |
| 1.0.0 | ✅ | ✅ | ✅ | ✅ |

## 4. API

> [!TIP] "ohos Support"列为 yes 表示 ohos 平台支持该属性；no 则表示不支持；partially 表示部分支持。使用方法跨平台一致，效果对标 iOS 或 Android。

| 名称 | 说明 | 类型 | 输入 | 输出 | ohos Support |
| --- | --- | --- | --- | --- | --- |
| showEnableAutoStartSettings | 弹出自启动引导对话框并跳转系统设置（映射 `showEnableAutoStart`） | function | `dialogTitle: string, dialogBody: string` | `Future<bool?>` | no |
| showDisableManufacturerBatteryOptimizationSettings | 弹出厂商省电优化引导对话框并跳转设置（映射 `showDisableManBatteryOptimization`） | function | `dialogTitle: string, dialogBody: string` | `Future<bool?>` | no |
| showDisableBatteryOptimizationSettings | 引导处理系统电池优化设置（映射 `showDisableBatteryOptimization`） | function | 无 | `Future<bool?>` | no |
| showDisableAllOptimizationsSettings | 一次性引导自启动、厂商省电、系统电池优化（映射 `disableAllOptimizations`） | function | `autoStartTitle, autoStartBody, manBatteryTitle, manBatteryBody` | `Future<bool?>` | no |
| isAutoStartEnabled | 查询当前应用自启动状态（getter） | function | 无 | `Future<bool?>` | yes |
| isBatteryOptimizationDisabled | 查询应用是否已加入系统忽略电池优化白名单（getter） | function | 无 | `Future<bool?>` | no |
| isManufacturerBatteryOptimizationDisabled | 查询用户是否已关闭厂商省电/耗电管理限制（getter，映射 `isManBatteryOptimizationDisabled`） | function | 无 | `Future<bool?>` | no |
| isAllBatteryOptimizationDisabled | 查询自启动、厂商省电、系统电池优化是否均已处理（getter，映射 `isAllOptimizationsDisabled`） | function | 无 | `Future<bool?>` | no |

## 5. 开源协议

本项目基于 [The MIT License](LICENSE)，请自由地享受和参与开源。
