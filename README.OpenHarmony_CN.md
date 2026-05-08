# disable_battery_optimization

本项目基于 [disable_battery_optimization](https://github.com/pvsvamsi/Disable-Battery-Optimizations) 开发。

## 简介

disable_battery_optimization 是一个 Flutter 插件，用于检查电池优化状态并引导用户进行相关设置。该插件支持查询应用自启动状态，并提供系统设置跳转功能。<br/>

## 下载安装

进入到工程目录并在 `pubspec.yaml` 中添加以下依赖：

```yaml
dependencies:
  disable_battery_optimization:
    git:
      url: https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization
      ref: 1.1.2-ohos-1.0.0
```

执行命令

```bash
flutter pub get
```

> TAG 命名规则：`原库版本-ohos-版本号-betax`。

| Flutter 框架版本 | TAG 名称 |
| ---------------- | ----------------------- |
| 3.7.12-ohos-1.1.3 | 1.1.2-ohos-1.0.0 |
| 3.22.1-ohos-1.1.0 | 1.1.2-ohos-1.0.0 |
| 3.27.5-ohos-1.0.4 | 1.1.2-ohos-1.0.0 |
| 3.35.8-ohos-0.0.2 | 1.1.2-ohos-1.0.0 |

## 约束与限制

### 兼容性

在以下版本中已测试通过

1. Flutter: 3.7.12-ohos-1.1.3; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6;
2. Flutter: 3.22.1-ohos-1.1.0; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6;
3. Flutter: 3.27.5-ohos-1.0.4; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6;
4. Flutter: 3.35.8-ohos-0.0.2; SDK: 5.0.0(12); IDE: DevEco Studio: 6.1.0.830; ROM: 6.1.0.117 SP6;

### 权限要求

无

## 使用示例

disable_battery_optimization 提供了简单易用的 API，以下片段展示了该插件最简单的使用方式：<br/>

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
              // 查询自启动状态
              MaterialButton(
                child: Text("Is Auto Start Enabled"),
                onPressed: () async {
                  bool isAutoStartEnabled =
                      await DisableBatteryOptimization.isAutoStartEnabled ?? false;
                  print("Auto start is ${isAutoStartEnabled ? "Enabled" : "Disabled"}");
                },
              ),
              // 查询电池优化状态
              MaterialButton(
                child: Text("Is Battery optimization disabled"),
                onPressed: () async {
                  bool isBatteryOptimizationDisabled =
                      await DisableBatteryOptimization.isBatteryOptimizationDisabled ?? false;
                  print("Battery optimization is ${!isBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
                },
              ),
              // 查询厂商电池优化状态
              MaterialButton(
                child: Text("Is Manufacturer Battery optimization disabled"),
                onPressed: () async {
                  bool isManBatteryOptimizationDisabled =
                      await DisableBatteryOptimization.isManufacturerBatteryOptimizationDisabled ?? false;
                  print("Manufacturer Battery optimization is ${!isManBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
                },
              ),
              // 查询所有优化状态
              MaterialButton(
                child: Text("Are All Battery optimizations disabled"),
                onPressed: () async {
                  bool isAllBatteryOptimizationDisabled =
                      await DisableBatteryOptimization.isAllBatteryOptimizationDisabled ?? false;
                  print("All Battery optimizations are disabled ${isAllBatteryOptimizationDisabled ? "True" : "False"}");
                },
              ),
              // 显示自启动设置
              MaterialButton(
                child: Text("Enable Auto Start"),
                onPressed: () {
                  DisableBatteryOptimization.showEnableAutoStartSettings(
                    "Enable Auto Start",
                    "Follow the steps and enable the auto start of this app",
                  );
                },
              ),
              // 显示电池优化设置
              MaterialButton(
                child: Text("Disable Battery Optimizations"),
                onPressed: () {
                  DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
                },
              ),
              // 显示厂商电池优化设置
              MaterialButton(
                child: Text("Disable Manufacturer Battery Optimizations"),
                onPressed: () {
                  DisableBatteryOptimization.showDisableManufacturerBatteryOptimizationSettings(
                    "Your device has additional battery optimization",
                    "Follow the steps and disable the optimizations to allow smooth functioning of this app",
                  );
                },
              ),
              // 显示所有优化设置
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

## 使用说明

### 1. 查询自启动状态

```dart
bool isAutoStartEnabled = await DisableBatteryOptimization.isAutoStartEnabled ?? false;
print("Auto start is ${isAutoStartEnabled ? "Enabled" : "Disabled"}");
```

### 2. 查询电池优化状态

```dart
bool isBatteryOptimizationDisabled = await DisableBatteryOptimization.isBatteryOptimizationDisabled ?? false;
print("Battery optimization is ${!isBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
```

### 3. 查询厂商电池优化状态

```dart
bool isManBatteryOptimizationDisabled = await DisableBatteryOptimization.isManufacturerBatteryOptimizationDisabled ?? false;
print("Manufacturer Battery optimization is ${!isManBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
```

### 4. 查询所有优化状态

```dart
bool isAllBatteryOptimizationDisabled = await DisableBatteryOptimization.isAllBatteryOptimizationDisabled ?? false;
print("All Battery optimizations are disabled ${isAllBatteryOptimizationDisabled ? "True" : "False"}");
```

### 5. 显示自启动设置

```dart
DisableBatteryOptimization.showEnableAutoStartSettings(
  "Enable Auto Start",
  "Follow the steps and enable the auto start of this app",
);
```

### 6. 显示电池优化设置

```dart
DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
```

### 7. 显示厂商电池优化设置

```dart
DisableBatteryOptimization.showDisableManufacturerBatteryOptimizationSettings(
  "Your device has additional battery optimization",
  "Follow the steps and disable the optimizations to allow smooth functioning of this app",
);
```

### 8. 显示所有优化设置

```dart
DisableBatteryOptimization.showDisableAllOptimizationsSettings(
  "Enable Auto Start",
  "Follow the steps and enable the auto start of this app",
  "Your device has additional battery optimization",
  "Follow the steps and disable the optimizations to allow smooth functioning of this app",
);
```

## 接口说明

> [!TIP] "ohos Support"列为 yes 表示 ohos 平台支持该属性，no 则表示不支持。使用方法跨平台一致，效果对标 iOS 或 Android 的效果。

| 名称 | 类型 | 参数类型 | 返回值 | OHOS 平台支持 | 描述 |
|------|------|----------|--------|---------------|------|
| showEnableAutoStartSettings() | 方法 | `String dialogTitle, String dialogBody` | `Future<bool?>` | no | 弹出自启动引导对话框并跳转系统设置 |
| showDisableManufacturerBatteryOptimizationSettings() | 方法 | `String dialogTitle, String dialogBody` | `Future<bool?>` | no | 弹出厂商省电优化引导对话框并跳转设置 |
| showDisableBatteryOptimizationSettings() | 方法 | 无 | `Future<bool?>` | no | 引导处理系统电池优化设置 |
| showDisableAllOptimizationsSettings() | 方法 | `String autoStartTitle, String autoStartBody, String manBatteryTitle, String manBatteryBody` | `Future<bool?>` | no | 一次性引导自启动、厂商省电、系统电池优化 |
| isAutoStartEnabled | 属性 | 无 | `Future<bool?>` | yes | 查询当前应用自启动状态 |
| isBatteryOptimizationDisabled | 属性 | 无 | `Future<bool?>` | no | 查询应用是否已加入系统忽略电池优化白名单 |
| isManufacturerBatteryOptimizationDisabled | 属性 | 无 | `Future<bool?>` | no | 查询用户是否已关闭厂商省电/耗电管理限制 |
| isAllBatteryOptimizationDisabled | 属性 | 无 | `Future<bool?>` | no | 查询自启动、厂商省电、系统电池优化是否均已处理 |

## 遗留问题

无

## 其他

无

## 目录结构

```
|---- 目录
|     |---- android   # android适配代码
|     |---- example   # 多平台的完整示例应用
|           |----lib  # 示例代码
|           |----ohos # 鸿蒙工程
|     |---- lib       # 核心代码实现
|           |---- disable_battery_optimization.dart  # 库的主入口文件
|     |---- ohos      # ohos适配代码
|     |---- test      # 单元测试文件
|     |---- CHANGELOG.md              # 更新日志
|     |---- LICENSE                   # 开源协议
|     |---- README.OpenHarmony_CN.md  # 中文文档
|     |---- README.OpenHarmony.md     # 英文文档
|     |---- pubspec.yaml              # 配置文件
```

## 贡献代码

使用过程中发现任何问题都可以提 [Issue](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization/issues) ，当然，也非常欢迎发 [PR](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization/pulls) 共建。

## 开源协议

本项目基于 [The MIT License](https://gitcode.com/OpenHarmony-Flutter/fluttertpc_disable_battery_optimization/blob/master/LICENSE) ，请自由地享受和参与开源。
