import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('in.jvapps.disable_battery_optimization');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('DisableBatteryOptimization', () {
    test('showEnableAutoStartSettings 调用正确的方法并传递参数', () async {
      String? capturedTitle;
      String? capturedBody;
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'showEnableAutoStart');
        expect(methodCall.arguments, isA<List<dynamic>>());
        final args = methodCall.arguments as List<dynamic>;
        expect(args.length, 2);
        capturedTitle = args[0] as String?;
        capturedBody = args[1] as String?;
        return true;
      });

      const title = '开启自启动';
      const body = '请在设置中开启自启动以保持应用运行';
      final result = await DisableBatteryOptimization.showEnableAutoStartSettings(
          title, body);

      expect(result, true);
      expect(capturedTitle, title);
      expect(capturedBody, body);
    });

    test('showDisableManufacturerBatteryOptimizationSettings 调用正确的方法', () async {
      String? capturedTitle;
      String? capturedBody;
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'showDisableManBatteryOptimization');
        final args = methodCall.arguments as List<dynamic>;
        expect(args.length, 2);
        capturedTitle = args[0] as String?;
        capturedBody = args[1] as String?;
        return true;
      });

      const title = '关闭省电优化';
      const body = '请关闭省电优化以保持后台运行';
      final result = await DisableBatteryOptimization
          .showDisableManufacturerBatteryOptimizationSettings(title, body);

      expect(result, true);
      expect(capturedTitle, title);
      expect(capturedBody, body);
    });

    test('showDisableBatteryOptimizationSettings 无参数调用', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'showDisableBatteryOptimization');
        expect(methodCall.arguments, isNull);
        return true;
      });

      final result =
          await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();

      expect(result, true);
    });

    test('showDisableAllOptimizationsSettings 传递四个参数', () async {
      List<String>? capturedArgs;
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'disableAllOptimizations');
        final args = methodCall.arguments as List<dynamic>;
        expect(args.length, 4);
        capturedArgs = args.cast<String>();
        return true;
      });

      const autoStartTitle = '自启动标题';
      const autoStartBody = '自启动内容';
      const manBatteryTitle = '省电标题';
      const manBatteryBody = '省电内容';

      final result = await DisableBatteryOptimization
          .showDisableAllOptimizationsSettings(
              autoStartTitle, autoStartBody, manBatteryTitle, manBatteryBody);

      expect(result, true);
      expect(capturedArgs, [
        autoStartTitle,
        autoStartBody,
        manBatteryTitle,
        manBatteryBody
      ]);
    });

    test('isAutoStartEnabled 返回布尔值', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'isAutoStartEnabled');
        return true;
      });
      expect(await DisableBatteryOptimization.isAutoStartEnabled, true);

      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return false;
      });
      expect(await DisableBatteryOptimization.isAutoStartEnabled, false);
    });

    test('isBatteryOptimizationDisabled 返回布尔值', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'isBatteryOptimizationDisabled');
        return true;
      });
      expect(
          await DisableBatteryOptimization.isBatteryOptimizationDisabled, true);
    });

    test('isManufacturerBatteryOptimizationDisabled 返回布尔值', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'isManBatteryOptimizationDisabled');
        return false;
      });
      expect(
          await DisableBatteryOptimization
              .isManufacturerBatteryOptimizationDisabled,
          false);
    });

    test('isAllBatteryOptimizationDisabled 返回布尔值', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'isAllOptimizationsDisabled');
        return true;
      });
      expect(
          await DisableBatteryOptimization.isAllBatteryOptimizationDisabled,
          true);
    });

    test('方法返回 null 时正确处理', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return null;
      });
      expect(await DisableBatteryOptimization.isAutoStartEnabled, isNull);
      expect(
          await DisableBatteryOptimization.showDisableBatteryOptimizationSettings(),
          isNull);
    });
  });
}
