import 'dart:async';
import 'package:flutter/material.dart';

class Stopwatch extends StatefulWidget {
  double currentX, currentY;
  Stopwatch(
    { Key? key, required this.currentX, required this.currentY}
    ) : super(key: key);

  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  int timemesure = 0;
  bool active = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.currentX,
      top: widget.currentY,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 200,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('経過時間${convertToTime(timemesure)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: timerButton1, child: Text(active ? '停止' : '開始')),
                const SizedBox(width: 5,),
                ElevatedButton(
                  onPressed: active? null : timerButton2, child: Text('リセット'),
                  style: ButtonStyle(
                    backgroundColor: active ? MaterialStateProperty.all<Color?>(Colors.grey[300]) : MaterialStateProperty.all<Color?>(Colors.blue[600]),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void timerButton1() {
    if(!active) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          timemesure++;
        });
      });
    } else if(active){
      _timer?.cancel();
      _timer = null;

    }
    setState(() {
      active = !active;
    });
  }

  void timerButton2() {
    setState(() {
      timemesure = 0;
    });
  }
  
  String convertToTime(int seconds) {
    int hour = (seconds / 3600).floor();
    int min = (seconds % 3600 / 60).floor();
    int rem = seconds % 60;
    return '${hour}時間${min}分${rem}秒';
  }
}