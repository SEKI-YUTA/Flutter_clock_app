import 'package:clock_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _fontSize = 40;
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
                      child: Slider(value: _fontSize, onChanged: (value) {
                        print(value);
                        context.read<MyClockSettings>().setTimeFontSize(value);
                        setState(() {
                          _fontSize = value;
                        });
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
                        onColorChanged: (Color color) {
                          context.read<MyClockSettings>().setFontColor(color);
                        },
                      )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('24時間表示'),
                    Switch(
                      value: context.watch<MyClockSettings>().timeFormat24,
                      onChanged: (value) {
                        context.read<MyClockSettings>().setTimeFormat24(value);
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