import 'package:flutter/material.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = '';

  @override
  void initState() {
    super.initState();
  }

  void _updateResult(String result) {
    setState(() {
      _result = result;
    });
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
              MaterialButton(
                  child: Text("Is Auto Start Enabled"),
                  onPressed: () async {
                    bool isAutoStartEnabled =
                        await DisableBatteryOptimization.isAutoStartEnabled ?? false;
                    String result = "Auto start is ${isAutoStartEnabled ? "Enabled" : "Disabled"}";
                    print(result);
                    _updateResult(result);
                  }),
              MaterialButton(
                  child: Text("Is Battery optimization disabled"),
                  onPressed: () async {
                    bool isBatteryOptimizationDisabled =
                        await DisableBatteryOptimization
                            .isBatteryOptimizationDisabled ?? false;
                    print(
                        "Battery optimization is ${!isBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
                  }),
              MaterialButton(
                  child: Text("Is Manufacturer Battery optimization disabled"),
                  onPressed: () async {
                    bool isManBatteryOptimizationDisabled =
                        await DisableBatteryOptimization
                            .isManufacturerBatteryOptimizationDisabled ?? false;
                    print(
                        "Manufacturer Battery optimization is ${!isManBatteryOptimizationDisabled ? "Enabled" : "Disabled"}");
                  }),
              MaterialButton(
                  child: Text("Are All Battery optimizations disabled"),
                  onPressed: () async {
                    bool isAllBatteryOptimizationDisabled =
                        await DisableBatteryOptimization
                            .isAllBatteryOptimizationDisabled ?? false;
                    String result = "All Battery optimizations are disabled: ${isAllBatteryOptimizationDisabled ? "True" : "False"}";
                    print(result);
                    _updateResult(result);
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                  child: Text("Enable Auto Start"),
                  onPressed: () {
                    DisableBatteryOptimization.showEnableAutoStartSettings(
                        "Enable Auto Start",
                        "Follow the steps and enable the auto start of this app");
                  }),
              MaterialButton(
                  child: Text("Disable Battery Optimizations"),
                  onPressed: () {
                    DisableBatteryOptimization
                        .showDisableBatteryOptimizationSettings();
                  }),
              MaterialButton(
                  child: Text("Disable Manufacturer Battery Optimizations"),
                  onPressed: () {
                    DisableBatteryOptimization
                        .showDisableManufacturerBatteryOptimizationSettings(
                        "Your device has additional battery optimization",
                        "Follow the steps and disable the optimizations to allow smooth functioning of this app");
                  }),
              MaterialButton(
                  child: Text("Disable all Optimizations"),
                  onPressed: () {
                    DisableBatteryOptimization.showDisableAllOptimizationsSettings(
                        "Enable Auto Start",
                        "Follow the steps and enable the auto start of this app",
                        "Your device has additional battery optimization",
                        "Follow the steps and disable the optimizations to allow smooth functioning of this app");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
