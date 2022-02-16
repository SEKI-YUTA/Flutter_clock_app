import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({ Key? key }) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  double _currentX = 0;
  double _currentY = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Stack(
        children: [
          Center(
              child: Text('${_currentX} x ${_currentY}'),
          ),
          Positioned(
            left: _currentX,
            top: _currentY,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amber
              )
            ),
          ),
          ElevatedButton(onPressed: ()=>print('pressed'), child: Text('Push!')),
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              // print('update');
              double currentX = details.localPosition.dx;
              double currentY = details.localPosition.dy;
              setState(() {
                _currentX = currentX;
                _currentY = currentY;
              });
            },
          )
        ],
      ),
    );
  }
}