import 'dart:async';

import 'package:clock_app/screens/setting_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';
import 'package:intl/intl.dart';


List<String> weekDays = ["月曜","火曜","水曜","木曜","金曜","土曜","日曜",];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft
  ]);
  Wakelock.enable();
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyClockSettings())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyClock(),
    );
  }
}

class MyClock extends StatefulWidget {
  const MyClock({ Key? key }) : super(key: key);

  @override
  State<MyClock> createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  int? month, day,weekDay;
  String time = "00:00:00";

  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    DateTime _now = DateTime.now();
    int _month = _now.month;
    int _day = _now.day;
    int _weekDay = _now.weekday;
    // var dateFormat = context.watch<MyClockSettings>().timeFormat24 ? DateFormat('HH:mm:ss') : DateFormat('hh:mm:ss');
    // var dateFormat = DateFormat(context.watch<MyClockSettings>().timeFormat24 ? 'HH:mm:ss' : 'hh:mm:ss');
    var dateFormat = DateFormat('HH:mm:ss');
    String formatted = dateFormat.format(_now);
    setState(() {
      time = formatted;
      month = _month;
      day = _day;
      weekDay = _weekDay;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            month != null ? Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${month}月 ${day}日 ${weekDays[weekDay! - 1].toString()}日', textAlign: TextAlign.left,),
                  Text(time, style: TextStyle(fontSize: double.parse(context.watch<MyClockSettings>()._timeFontSize.toString()), fontWeight: FontWeight.bold, color: context.watch<MyClockSettings>().fontColor),),
                ],
              ),
            ) : Text('しばらくお待ち下さい'),
            Positioned(
              left: 10,
              bottom: 10,
              child: IconButton(onPressed: () => showMaterialModalBottomSheet(
                backgroundColor: Colors.white.withOpacity(0.8),
                context: context,
                builder: (context) => SettingScreen()
                ),
                icon: Icon(Icons.settings)),
            ),
          ],
        ),
      ),
    ); 
    
  }
}

class MyClockSettings with ChangeNotifier, DiagnosticableTreeMixin {
  double _timeFontSize = 40;
  Color _fontColor = Colors.black;
  bool _timeFormat24 = true;
  double get timeFontSize => _timeFontSize;
  Color get fontColor => _fontColor;
  bool get timeFormat24 => _timeFormat24;

  void setTimeFontSize(double _newSize) {
    _timeFontSize = _newSize;
  }
  void setFontColor(Color _newColor) {
    _fontColor = _newColor;
  }
  void setTimeFormat24(bool is24) {
    _timeFormat24 = is24;
  }
}