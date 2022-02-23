import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:app_settings/app_settings.dart';

class BatteryIndicator extends StatefulWidget {
  const BatteryIndicator({ Key? key }) : super(key: key);

  @override
  _BatteryIndicatorState createState() => _BatteryIndicatorState();
}

class _BatteryIndicatorState extends State<BatteryIndicator> {
  final battery = Battery();
  int? _batteryLevel;
  BatteryState? _batteryState;

  @override
  void initState() {
    super.initState();
    initBatteryLevel();
  }
  void initBatteryLevel() async {
    int batteryLevel = await battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      int batteryLevel = await battery.batteryLevel;
      setState(() {
        _batteryLevel = batteryLevel;
      });
    });
    battery.onBatteryStateChanged.listen((event) {
      setState(() {
        _batteryState = event;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppSettings.openBatteryOptimizationSettings();
      },
      child: Container(
        width: 60,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _batteryState == BatteryState.charging ? Icon(Icons.battery_charging_full) : Icon(Icons.battery_full),
            Text('${_batteryLevel}%')
          ],
        ),
      ),
    );
  }
}