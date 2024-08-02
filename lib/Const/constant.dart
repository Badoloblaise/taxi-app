import 'package:flutter/material.dart';

const primary = Color.fromARGB(227, 255, 115, 1);

const bgDark = Color.fromARGB(0, 0, 0, 0);
const bgLight = Color.fromARGB(255, 255, 255, 255);

const prText = Colors.black;
const lgText = Color.fromARGB(255, 189, 189, 189);
const phText = Color.fromARGB(255, 224, 224, 224);

extension AppContext on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  Future push(Widget widget) async {
    return Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  void pop() async {
    return Navigator.pop(this);
  }
}
