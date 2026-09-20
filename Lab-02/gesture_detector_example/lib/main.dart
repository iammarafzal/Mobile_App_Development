import 'package:flutter/material.dart';

void main() => runApp(const GestureDetectorExample());

class GestureDetectorExample extends StatelessWidget {
  const GestureDetectorExample({super.key});

  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: "Gesture Dectector Example",
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Gesture Detector Example'),
          ),
        ),
        body: const GestureDetectorWidget(),
      ),
    );
  }
}

class GestureDetectorWidget extends StatefulWidget {
  const GestureDetectorWidget({super.key});

  @override
  State<GestureDetectorWidget> createState() => GestureDetectorWidgetState();
}

class GestureDetectorWidgetState extends State<GestureDetectorWidget> {
  Color _color = Colors.green;
  String _SelectedColor = "Your current color is green";

  void _onTap() {
    setState(() {
      _color = Colors.red;
      _SelectedColor = "You are currently selected Tap and its color is red";
    });
  }

  void _onDoubleTap() {
    setState(() {
      _color = Colors.blue;
      _SelectedColor = "You are currently selected double Tap and its color is blue";
    });
  }

  void _onDrag() {
    setState(() {
      _color = Colors.yellow;
      _SelectedColor = "You are currently selected drag and its color is yellow";
    });
  }

  void _onLongPress() {
    setState(() {
      _color = Colors.black;
      _SelectedColor = "You are currently selected long press and its color is black";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _onTap,
          onDoubleTap: _onDoubleTap,
          onVerticalDragEnd: (_) =>  _onDrag(),
          onLongPress: _onLongPress,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        Text("$_SelectedColor", style: TextStyle(color: _color)),
      ]
    );
  }
}