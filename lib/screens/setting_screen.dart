import 'package:clock_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
    //ステートからスライダーに値を渡さないとスライダーのつまみが動かないためステートで渡す

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('時刻の文字サイズ'),
                    Expanded(
                      child: Slider(value: context.watch<MyClockSettings>().timeFontSize, onChanged: (value) async {
                        print(value);
                        context.read<MyClockSettings>().setTimeFontSize(value);
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('timeFontSize', value.toString());
                      },
                      min: 30,
                      max: 180,
                      divisions: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('時刻の文字カラー'),
                    FittedBox(
                      child: MaterialPicker(
                        pickerColor: context.watch<MyClockSettings>().fontColor,
                        onColorChanged: (Color color) async {
                          print(colorToHex(color));
                          context.read<MyClockSettings>().setFontColor(color);
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('fontColor', colorToHex(color));
                        },
                      )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('ストップウィッチを表示'),
                    Switch(
                      value: context.watch<MyClockSettings>().showStopwatch,
                      onChanged: (value) async {
                        print(value);
                        context.read<MyClockSettings>().setShowStopwatch(value);
                        final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showStopwatch', value);
                      }
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}